import 'package:flutter/material.dart';

void main() {
  runApp(SplashPage());
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 100.0,
              width: 500.0,
              color: Colors.black,
            ),
            Container(
              child: Image.asset('lib/images/Splash_Character.png'),
              height: 100.0,
              width: 400.0,
            ),
            Container(
              height: 20.0,
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
            Container(
              height: 12.0,
              width: 500.0,
              color: Colors.black,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'ID를 입력해주세요',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 10.0,
              width: 500.0,
              color: Colors.black,
            ),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'PASSWORD를 입력해주세요',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 10.0,
              width: 500.0,
              color: Colors.black,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(200, 50),
              ),
              label: Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              icon: Icon(Icons.door_front_door_sharp,
                  size: 18, color: Colors.white),
            ),
            Container(
              height: 10.0,
              width: 500.0,
              color: Colors.black,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(200, 50),
              ),
              child: Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
