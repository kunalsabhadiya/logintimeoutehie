import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logintimeoutehie/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSetUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthSetUpScreen();
}

class _AuthSetUpScreen extends State<AuthSetUpScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: "Put your finder on FingerPrint senser to Proceed.",
          options: AuthenticationOptions(biometricOnly: true));
      if (result) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("AuthActivation", true);
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
    _printData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Two Factor Authentication",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/assets/img.png", width: 350,height: 350,),
              Text(
                "If you want to secure your data, please\n turn on two factor authentication.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    checkAuth();
                  },
                  child: Text("Biometric Authentication")),
              SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool("AuthActivation", false);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  },
                  child: Text("Remind me, later.",style: TextStyle(color: Colors.red),)),
            ],
          ),
        ),
      ),
    );
  }
  void _printData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('start');
    print(prefs.getString("email"));
    print(prefs.getString("password"));
    print(prefs.getBool("isLoggedIn"));
    print(prefs.containsKey('InstanceID'));
    print(prefs.getString("InstanceID"));
    print(prefs.getBool("keepMeLoggedIn"));
    print('end');
  }
}
