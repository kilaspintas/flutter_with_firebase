import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_with_firebase/pages/HomePage.dart';
import 'package:flutter_with_firebase/pages/SignInPage.dart';
import 'package:flutter_with_firebase/pages/SignUpPage.dart';
import 'package:flutter_with_firebase/services/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  Auth authClass = Auth();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? token = await authClass.getToken();
    if(token!=null){
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}