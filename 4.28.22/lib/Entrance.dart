import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 20.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Text(
                    '북클럽 입장',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Container(
                    height: 100.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Container(
                    child: Image.asset('lib/images/egg.png'),
                    height: 150.0,
                    width: 300.0,
                  ),
                  Container(
                    height: 20.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.pen,
                          color: Colors.white,
                        ),
                        hintText: '닉네임을 입력해주세요',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
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
                      minimumSize: Size(360, 50),
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
                    height: 40.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Text(
                    '''다른 사람의 초대번호를 입력하고
    북클럽 방으로 입장해보세요.''',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    height: 10.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        color: Colors.grey[850],
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: '영문,숫자 9자리 조합',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        width: 2.0,
                        color: Colors.grey,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // LobbyPage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LobbyPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          minimumSize: Size(30, 50),
                        ),
                        label: Text(
                          '입장하기',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        icon: Icon(Icons.add, size: 18, color: Colors.red),
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
      ),
    );
  }
}
