import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _Splash();

}

class _Splash extends State<Splash>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=> _checkLoginStatus()
        );

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Center(
       child: Image.asset("images/assets/app_logo.png",width: 200,height: 200, ),
     )
   );
  }



  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(sessionStateStream: StreamController<SessionState>(),)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login(sessionStateStream: StreamController<SessionState>(), loggedOutReason: '',)),
      );
    }
  }

}