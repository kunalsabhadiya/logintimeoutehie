
import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setBool("isLoggedIn", false);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login(),));
          },
          child: Text('Logout'),
        ),
      ),
    );
  }

  }