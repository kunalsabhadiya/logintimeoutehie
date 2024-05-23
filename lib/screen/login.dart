import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/AuthSetUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController InstanceIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isFirstTimeLogin = false;
  bool keepMeLoggedIn = false;
  bool isAuthActivated = false;

  @override
  void initState() {
    super.initState();
    _isFirstTimeLogin();
    _isAuthSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            isFirstTimeLogin
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 0, bottom: 0),
                    child: TextField(
                      controller: InstanceIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'InstanceID',
                      ),
                    )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Id',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Row(
                children: [
                  Checkbox(
                    value: keepMeLoggedIn,
                    onChanged: (value) {
                      setState(() {
                        keepMeLoggedIn = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  //Text
                  const SizedBox(width: 10), //SizedBox
                  const Text(
                    'Keep me logged in. ',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
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
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ))),
                    child: const Text(
                      'Log in ',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      if (!emailController.text.isEmpty &&
                          !passwordController.text.isEmpty) {
                        _saveLoginStatus();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => isAuthActivated
                                ? HomeScreen()
                                : AuthSetUpScreen(),
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

  void _saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", emailController.text);
    prefs.setString("password", passwordController.text);
    prefs.setBool("isLoggedIn", true);
    prefs.setString("InstanceID", InstanceIdController.text);
    prefs.setBool("keepMeLoggedIn", keepMeLoggedIn);
  }

  void _isFirstTimeLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('InstanceID');
    bool? keepMeLoggedIn = prefs.getBool('keepMeLoggedIn');
    setState(() {
      isFirstTimeLogin = isLoggedIn;
      this.keepMeLoggedIn = keepMeLoggedIn!;
    });
    }

  void _isAuthSet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('AuthActivation');
    setState(() {
      isAuthActivated =  isLoggedIn;
    });
    }
}
