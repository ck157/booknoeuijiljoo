import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> images = [
    Image(image: AssetImage('assets/lib/images/one.jpg')),
    Image(image: AssetImage('assets/lib/images/two.jpg')),
    Image(image: AssetImage('assets/lib/images/three.jpg')),
    Image(image: AssetImage('assets/lib/images/four.jpg')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "쓰레드/메모 목록",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 30,
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: TabBar(
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(text: '커뮤니티'),
                                    Tab(text: '나만의 메모장'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "내가 쓴 글보기",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: EdgeInsets.all(8),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100)),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemBuilder: (BuildContext, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(images[index]),
                                    ),
                                    title: Text(
                                      "24 p.g.",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text("책이 너무 재미있어요",
                                        style: TextStyle(color: Colors.white)),
                                    trailing: Icon(
                                      CupertinoIcons.hand_thumbsup,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                itemCount: images.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(5),
                                scrollDirection: Axis.vertical,
                              ),
                            ])),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
