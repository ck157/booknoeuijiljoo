import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 150.0,
              width: 500.0,
              color: Colors.black,
            ),
            Container(
              child: Image.asset('assets/splash.png'),
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
              height: 12.0,
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
          ],
        ),
      ),
    );
  }
}
