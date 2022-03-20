import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/pages/SignInPage.dart';
import 'package:flutter_with_firebase/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();

}

class _HomePage extends State<HomePage>{
  Auth authClass = Auth();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            await authClass.logout();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (builder) => const SignInPage()),
                    (route) => false);
          },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}