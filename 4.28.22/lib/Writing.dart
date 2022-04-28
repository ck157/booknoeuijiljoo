import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(WritingPage());
}

class WritingPage extends StatelessWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Feed(),
    );
  }
}

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
  }) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  bool isSecret = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[850],
                  title: Text('''작성중인 글이 있어요! 
뒤로가면 저장되지 않아요. 
뒤로 갈까요?''',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "이어서 작성하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); //로비페이지로 연동시켜야 함
                      },
                      child: Text(
                        "뒤로가기",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '저장',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        title: Text("피드 작성"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1.0,
                width: 500.0,
                color: Colors.white,
              ),
              Row(
                children: [
                  Text(
                    "페이지 수",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "숫자를 입력해주세요.",
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1.0,
                width: 500.0,
                color: Colors.white,
              ),
              Row(
                children: [
                  Text(
                    "공개여부",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSecret = !isSecret;
                      });
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: isSecret ? Colors.red : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    '비밀 피드',
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.0,
                      color: isSecret ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                height: 5.0,
                width: 500.0,
                color: Colors.black,
              ),
              Container(
                height: 1.0,
                width: 500.0,
                color: Colors.white,
              ),
              TextField(
                style: TextStyle(fontSize: 28, color: Colors.white),
                decoration: InputDecoration(
                  labelText: "글을 입력해주세요.",
                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
