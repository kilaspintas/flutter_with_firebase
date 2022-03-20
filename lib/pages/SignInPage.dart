import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_with_firebase/pages/HomePage.dart';
import 'package:flutter_with_firebase/pages/SignUpPage.dart';
import 'package:flutter_with_firebase/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPage createState() => _SignInPage();

}

class _SignInPage extends State<SignInPage>{
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool circular = false;

  Auth authClass = Auth();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem(
                  "assets/google.svg",
                  "Continue with Google",
                  25,
                    ()async{
                  await authClass.googleSignIn(context);
                },
              ),
              SizedBox(
                height: 15,
              ),
              buttonItem(
                  "assets/phone.svg",
                  "Continue with Mobile",
                  30,
                    (){

                },
              ),
              SizedBox(
                height: 15,
              ),

              Text("Or", style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
              SizedBox(
                height: 15,
              ),
              textItem("Email", _emailController, false),
              SizedBox(
                height: 15,
              ),
              textItem("Password", _passwordController, true),
              SizedBox(
                height: 30,
              ),
              colorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (builder) => const SignUpPage()),
                              (route) => false);
                    },
                    child: new Text('SignUp', style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Forgot Password ? ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),)
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: () async{
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
          );
        }catch(e){
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          circular = false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (builder) => HomePage()),
                (route) => false);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ])
        ),
        child: Center(child: circular?CircularProgressIndicator()
            : Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20),
        )),
      ),
    );
  }

  Widget buttonItem(String pict, String namaTombol, double size, VoidCallback onTap){
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                pict,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(namaTombol, style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(String tulisan, TextEditingController controller, bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
            fontSize: 17,
            color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: tulisan,
          labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}