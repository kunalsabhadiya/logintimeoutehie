import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
  final StreamController<SessionState> sessionStateStream;
  late String loggedOutReason;

  Login({required this.sessionStateStream, required this.loggedOutReason});
}

class _Login extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Image.asset('images/assets/app_logo.png')),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Id',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 65,
              width: 360,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )
                      )
                    ),
                    child: const Text(
                      'Log in ',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async{


                      if(!emailController.text.isEmpty && !passwordController.text.isEmpty){
                        _saveLoginStatus();
                        widget.sessionStateStream.add(SessionState.startListening);
                        widget.loggedOutReason = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(
                              sessionStateStream: widget.sessionStateStream,
                            ),
                          ),
                        );
                      }

                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _saveLoginStatus() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email",  emailController.text);
    prefs.setString("password",  passwordController.text);
    prefs.setBool("isLoggedIn", true);
  }
}
