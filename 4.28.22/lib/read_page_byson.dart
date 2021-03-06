import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Writing.dart';
import 'package:provider/provider.dart';

import 'Lobby.dart';
import 'auth_service.dart';
import 'book_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => BookService()),
      ],
      child: ReadPage(),
    ),
  );
}

class ReadPage extends StatefulWidget {
  const ReadPage({Key? key}) : super(key: key);

  @override
  State<ReadPage> createState() => ReadPageState();
}

class ReadPageState extends State<ReadPage> {
  int currentIndex = 0;
  int currentPage = 0;

  final _items = ['전체 피드', '내 비밀 피드'];
  var _selected = '전체 피드';
  List _valueList = ['전체 피드'];

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LobbyPage()),
                );
              },
            ),
            backgroundColor: Colors.black87,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(CupertinoIcons.bell),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.black.withAlpha(220),
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: Colors.white70,
                      ),
                      Text(
                        '   나만의 메모장',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: Colors.white70,
                      ),
                      Text(
                        '   커뮤니티',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.create_outlined,
                        color: Colors.white70,
                      ),
                      Text(
                        '   글쓰기',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.undo_outlined,
                        color: Colors.white70,
                      ),
                      Text(
                        '   광장으로 돌아가기',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              CustomScrollView(
                physics: ScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.black87,
                    expandedHeight: 300,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '          지금 이쪽을 읽고 있는 중이에요.\n직접 입력하거나 버튼을 이용해 조절해 주세요.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(200),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //      IconButton(
                              //        onPressed: () {
                              //           setState(() {
                              //            currentPage = currentPage - 1;
                              //           });
                              //         },
                              //        icon: Icon(
                              //           Icons.expand_more,
                              //           color: Colors.white70,
                              //         size: 60,
                              //        ),
                              //     ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 130,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 38),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    labelText: '현재 페이지',
                                    labelStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ),
                              Text(
                                ' p ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    ' / ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '$currentPage', //로비페이지의 전체 쪽수가져오기//
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '  p',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //   IconButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         currentPage = currentPage + 1;
                              //       });
                              //     },
                              //     icon: Icon(
                              //       Icons.expand_less,
                              //        color: Colors.white70,
                              //       size: 60,
                              //     ),
                              //   ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            child: Center(
                              child: Text(
                                '현재 페이지까지 질주 피드들을 확인해보세요!',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.red, width: 2),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              DropdownButton(
                                  value: _selected,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  dropdownColor: Colors.grey.shade700,
                                  underline: DropdownButtonHideUnderline(
                                      child: Container()),
                                  items: _items
                                      .map(
                                        (value) => DropdownMenuItem(
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.white,
                                                decorationColor: Colors.white),
                                          ),
                                          value: value,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selected = value as String;
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      child: FutureBuilder<QuerySnapshot>(
                          future: bookService.read(user.uid),
                          builder: (context, snapshot) {
                            final documents =
                                snapshot.data?.docs ?? []; // 포스트 가져오기
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                final doc = documents[index];
                                String post = doc.get('post');
                                String page = doc.get('page');
                                bool isDone = doc.get('isPrivate');
                                return Container(
                                  color: Colors.black,
                                  width: double.infinity,
                                  height: 90,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            page,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.blue),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                "비밀",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            width: 80,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                  5,
                                                )),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        post,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text('00/00/00'),
                                          Spacer(),
                                          Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 1,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  // child: ListTile(
                                  //   title: Row(
                                  //     children: [
                                  //       Text(
                                  //         "24p",
                                  //         style: TextStyle(
                                  //             fontSize: 17, color: Colors.blue),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 20,
                                  //       ),
                                  //       Container(
                                  //         child: Center(
                                  //           child: Text(
                                  //             '내 공개 피드',
                                  //             style: TextStyle(
                                  //                 color: Colors.red, fontSize: 13),
                                  //           ),
                                  //         ),
                                  //         width: 80,
                                  //         height: 20,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.all(Radius.circular(
                                  //               5,
                                  //             )),
                                  //             border: Border.all(
                                  //               width: 1,
                                  //               color: Colors.red,
                                  //             )),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   subtitle: Text(
                                  //     "책이 너무 재미있어요",
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  //   trailing: Icon(
                                  //     CupertinoIcons.hand_thumbsup,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                );
                              },
                              shrinkWrap: true,
                              padding: EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                            );
                          }),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 30,
                bottom: 20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                      30,
                    )),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WritingPage()),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.pen,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // body: Column(
          //   children: [
          //     MyBookPetWidget(),
          //     SizedBox(
          //       height: 20,
          //     ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: Container(
          //         width: 70,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: Container(
          //         width: 70,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: Container(
          //         width: 70,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: Container(
          //         width: 70,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),

          // ],
          // ),
        );
      },
    );
  }
}

// Tab controller version
// Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         DefaultTabController(
//             length: 2, // length of tabs
//             initialIndex: 0,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     color: Colors.black87,
//                     child: TabBar(
//                       labelColor: Colors.white,
//                       unselectedLabelColor: Colors.black,
//                       tabs: [
//                         Tab(text: '커뮤니티'),
//                         Tab(text: '나만의 메모장'),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: 16, left: 16, right: 16),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "내가 쓴 글보기",
//                         hintStyle: TextStyle(
//                             color: Colors.grey.shade600),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.grey.shade600,
//                           size: 20,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         contentPadding: EdgeInsets.all(8),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                                 color: Colors.grey.shade100)),
//                       ),
//                     ),
//                   ),
//                   ListView.builder(
//                     itemBuilder: (BuildContext, index) {
//                       return ListTile(
//                         leading: CircleAvatar(),
//                         title: Text(
//                           "24 p.g.",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         subtitle: Text("책이 너무 재미있어요",
//                             style:
//                                 TextStyle(color: Colors.white)),
//                         trailing: Icon(
//                           CupertinoIcons.hand_thumbsup,
//                           color: Colors.white,
//                         ),
//                       );
//                     },
//                     itemCount: 10,
//                     shrinkWrap: true,
//                     padding: EdgeInsets.all(5),
//                     scrollDirection: Axis.vertical,
//                   ),
//                 ])),
//       ]),
// ),