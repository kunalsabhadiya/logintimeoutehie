import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutHandler{
 static BuildContext? context;
  Timer? timer;
  static late LogOutHandler logOutHandler;

  static getInstance(BuildContext ctx) {
    context = ctx;
    if(logOutHandler == null){
      logOutHandler = LogOutHandler();
    }
    return logOutHandler;
  }

  void startTimer() async{
    if (await isLoggedIn()) {
      const time = Duration(seconds: 10);
      timer = Timer(time, () {
        logout(context!);
      });
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool('isLoggedIn') ?? false;
  }

  void logout(BuildContext ctx) async{
    timer?.cancel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (ctx) => Login(sessionStateStream: StreamController<SessionState>() , loggedOutReason: '',)));
  }

}