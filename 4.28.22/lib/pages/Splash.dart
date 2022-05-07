import 'dart:async';

import 'package:flutter/material.dart';

import 'Entrance.dart';
import 'LoginPage.dart';

void main() {
  runApp(SplashPage());
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 150.0,
            width: 500.0,
            color: Colors.black,
          ),
          Container(
            child: Image.asset('lib/images/Splash_Character.png'),
            height: 180.0,
            width: 400.0,
          ),
          Container(
            height: 25.0,
            width: 500.0,
            color: Colors.black,
          ),
          Text(
            '북노의 질주',
            style: TextStyle(
                fontFamilyFallback: ['CookieRun'],
                fontSize: 48.0,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 10.0,
            width: 500.0,
            color: Colors.black,
          ),
          Text(
            '피드로 함께하는 독서 레이싱',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 25.0,
            width: 480.0,
            color: Colors.black,
          ),
          Container(
            color: Colors.grey[900],
            height: 25.0,
            width: 180.0,
            child: Text(
              '앱에 접속 중입니다.',
              style: TextStyle(
                  fontFamilyFallback: ['CookieRun'],
                  fontSize: 16.0,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
