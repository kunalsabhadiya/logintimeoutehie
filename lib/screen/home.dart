import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:provider/provider.dart';

import '../rootapp.dart';

class HomeScreen extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const HomeScreen({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
/*  late TimerModel timerModel;

  @override
  void initState() {
    super.initState();
    timerModel = Provider.of<TimerModel>(context, listen: false);
    startLogoutTimer();
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.sessionStateStream.add(SessionState.stopListening);
        widget.sessionStateStream.add(SessionState.startListening);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("Welcome"),
        ),
      ),
    );
  }

/*  void startLogoutTimer() {
    timerModel.startTimer();
  }

  @override
  void dispose() {
    timerModel.resetTimer();
    super.dispose();
  }*/
}
