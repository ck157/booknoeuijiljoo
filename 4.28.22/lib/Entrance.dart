import 'package:flutter/material.dart';

import 'Lobby.dart';

void main() {
  runApp(EntrancePage());
}

class EntrancePage extends StatelessWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 30.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Text(
                  '북클럽 입장',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Container(
                  height: 40.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Container(
                  child: Image.asset('lib/images/Splash_Character.png'),
                  height: 180.0,
                  width: 400.0,
                ),
                Container(
                  height: 20.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Text(
                  'bookiebookie33',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Container(
                  height: 50.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // LobbyPage로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LobbyPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(380, 50),
                  ),
                  label: Text(
                    '내 북클럽 입장하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  icon: Icon(Icons.add, size: 18, color: Colors.white),
                ),
                Container(
                  height: 60.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Text(
                  '''다른 사람의 초대번호를 입력하고
    북클럽 방으로 입장해보세요.''',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 10.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Container(
                      width: 200.0,
                      child: Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "영문,숫자 9자리 조합",
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 20.0,
                      width: 2.0,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: Size(30, 50),
                      ),
                      label: Text(
                        '입장하기',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                      icon: Icon(Icons.add, size: 18, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  height: 10.0,
                  width: 500.0,
                  color: Colors.black,
                ),
                Text(
                  '초대 번호를 다시 확인해주세요.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
