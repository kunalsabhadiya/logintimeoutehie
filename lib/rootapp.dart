import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logintimeoutehie/screen/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerModel extends ChangeNotifier {
  Timer? _timer;
  bool _isLoggedIn = true;

  TimerModel() {
    startTimer();
  }

  bool get isLoggedIn => _isLoggedIn;

  void startTimer() {
    if (_isLoggedIn) {
      _timer?.cancel();
      const time = Duration(seconds: 10);
      _timer = Timer(time, () {
        logOutUser();
      });
    }
  }

  void logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    startTimer();
  }
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const Splash(),
    );
  }
}
