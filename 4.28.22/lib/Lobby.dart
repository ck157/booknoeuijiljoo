import 'package:booknoejilju/pages/bookclub_rule.dart';
import 'package:booknoejilju/pages/read_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'Entrance.dart';
import 'LoginPage.dart';
import 'Splash.dart';
import '../services/auth_service.dart';
import '../services/book_service.dart';
import '../services/bookclub_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => BookService()),
      ],
      child: LobbyPage(),
    ),
  );
}

class LobbyPage extends StatefulWidget {
  LobbyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyState();
}

class _LobbyState extends State<LobbyPage> {
  String date = '목표달성일을\n설정해보세요    ';

  TextEditingController pageController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      pageController.text = await Provider.of<ClubService>(context)
          .gettotalpages('zgYvrD8wclE1Fd4yiqhc');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // TextEditingController pageController = TextEditingController();
    TextEditingController _todayController = TextEditingController();

    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final authService = context.read<AuthService>();
        final user = authService.currentUser()!;
        return Consumer<ClubService>(
          builder: (context, clubService, child) {
            return FutureBuilder<QuerySnapshot>(
              future: clubService.getdocId(user.uid),
              builder: (context, snapshot) {
                final docs = snapshot.data?.docs;
                final doc = docs![0];

                String inviteCode = doc.get('docId');

                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    backgroundColor: Colors.black87,
                    appBar: AppBar(
                      actions: [
                        IconButton(
                          onPressed: () {
                            // 로그아웃
                            context.read<AuthService>().signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashPage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.logout_rounded),
                        ),
                      ],
                      centerTitle: true,
                      title: Text(
                        'My 북클럽 로비',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.black87,
                      bottom: PreferredSize(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              // 날짜 받아주는 변수
                              Text(
                                dateStr,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '오늘의 질주 현황',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        preferredSize: Size.fromHeight(10),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReadPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  '독서 시작',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              suffixIcon: Icon(
                                CupertinoIcons.pen,
                                color: Colors.white,
                              ),
                              hintText: '책 제목을 입력하세요',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            autofocus: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade800,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '목표 달성일 🚩',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          maxTime: DateTime(2023, 6, 7),
                                          onChanged: (e) {
                                            setState(() {
                                              date = DateFormat('yyyy-MM-dd')
                                                  .format(e);
                                            });
                                          },
                                          onConfirm: (e) {
                                            setState(() {
                                              date = DateFormat('yyyy-MM-dd')
                                                  .format(e);
                                            });
                                          },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.ko,
                                        );
                                      },
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white54,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: Center(
                              child: Text(
                                '초대 코드로 파티원을 초대하면 북클럽 장이 됩니다.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Colors.grey.shade800,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // 초대 코드 생성.. or 아이디로 초대??
                                          inviteCode,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),

                                        // Text(
                                        //   '목표 달성일을 \n설정해보세요!',
                                        //   style: TextStyle(
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: inviteCode));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('초대 코드가 클립보드에 복사되었습니다.'),
                                    ));
                                  },
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width *
                                        0.48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.red.shade800,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            // 초대 코드 생성.. or 아이디로 초대??
                                            '초대 코드 복사',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                            size: 17,
                                          )

                                          // Text(
                                          //   '목표 달성일을 \n설정해보세요!',
                                          //   style: TextStyle(
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(5),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          /////// 밑에 6개
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 30,
                                        ),
                                        child: Text(
                                          '6%',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 10,
                                        ),
                                        child: Text(
                                          '독서 달성률',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.465,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 30,
                                        ),
                                        child: Text(
                                          '97등',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 10,
                                        ),
                                        child: Text(
                                          '내 현재 순위',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.465,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 30,
                                        ),
                                        child: Text(
                                          '25일',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 10,
                                        ),
                                        child: Text(
                                          '남은 질주일',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.465,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 30,
                                        ),
                                        child: Text(
                                          '117명',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                          top: 10,
                                        ),
                                        child: Text(
                                          '현재 북클럽 참여 인원 >',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.465,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 30,
                                              ),
                                              child: TextFormField(
                                                controller: pageController,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  fillColor: Colors.white,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                top: 10,
                                              ),
                                              child: Text(
                                                '총 페이지 수',
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.465,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        bottom: 0,
                                        child: IconButton(
                                          icon: Icon(CupertinoIcons.pen),
                                          onPressed: () {
                                            clubService.total_page_update(
                                                inviteCode,
                                                pageController.text);
                                          },
                                          color: Colors.white,
                                          iconSize: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20.0,
                                              top: 30,
                                            ),
                                            child: TextFormField(
                                              controller: _todayController,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                fillColor: Colors.white,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            // child: Text(
                                            //   '45p',
                                            //   style: TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 30,
                                            //     fontWeight: FontWeight.bold,
                                            //   ),
                                            // ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20.0,
                                              top: 10,
                                            ),
                                            child: Text(
                                              '오늘 목표',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.465,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      bottom: 0,
                                      child: IconButton(
                                        icon: Icon(CupertinoIcons.pen),
                                        onPressed: () {
                                          clubService.today_page_update(
                                              inviteCode,
                                              _todayController.text);
                                        },
                                        color: Colors.white,
                                        iconSize: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookClubRule()),
                              ),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 30.0),
                                      child: Text(
                                        '북클럽 룰을 확인해 보세요',
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
