import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

import 'home.dart';
import 'login.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => _Splash();
}

class _Splash extends State<Splash> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthActivated = false;

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: "Put your finder on FingerPrint senser to Proceed.",
          options: const AuthenticationOptions(biometricOnly: true));
      if (result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }
    } else {
      print("biometric not found");
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => _checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "images/assets/app_logo.png",
            width: 200,
            height: 200,
          ),
        ));
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isactivated = prefs.getBool("AuthActivation") ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool keepmeloggedIn = prefs.getBool('keepMeLoggedIn') ?? false;
    if (isLoggedIn && keepmeloggedIn) {
      if (isactivated) {
        checkAuth();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }
}
