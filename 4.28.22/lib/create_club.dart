import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Lobby.dart';

class CreateClub extends StatefulWidget {
  CreateClub({Key? key}) : super(key: key);

  @override
  State<CreateClub> createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  TextEditingController _clubname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('방 제목 입력'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _clubname,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                hintText: '방 제목을 입력하세요',
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButton.icon(
            onPressed: () {
              // LobbyPage로 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LobbyPage(),
                  //create function
                ),
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
        ],
      ),
    );
  }
}
