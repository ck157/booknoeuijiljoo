import 'package:flutter/material.dart';

import 'Splash.dart';
import 'Writing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
