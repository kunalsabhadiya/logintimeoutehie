import 'package:flutter/material.dart';
import 'package:logintimeoutehie/rootapp.dart';
import 'package:provider/provider.dart';

import 'app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
   /* MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()),
        // Other providers if needed
      ],
      child: */MyApp(),
   // ),
  );
}

