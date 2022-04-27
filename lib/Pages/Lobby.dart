import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lobby extends StatefulWidget {
  Lobby({Key? key}) : super(key: key);

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
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
                  '2022년 03월 19일',
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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade800,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '목표 달성일',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '목표 달성일을 \n설정해보세요!',
                        style: TextStyle(
                          color: Colors.white,
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
                    width: MediaQuery.of(context).size.width * 0.48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      color: Colors.grey.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // 초대 코드 생성.. or 아이디로 초대??
                            'asdfasgddsf',
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
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.red.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // 초대 코드 생성.. or 아이디로 초대??
                            '초대 코드 복사',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MediaQuery.of(context).size.width * 0.465,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MediaQuery.of(context).size.width * 0.465,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MediaQuery.of(context).size.width * 0.465,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MediaQuery.of(context).size.width * 0.465,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 30,
                          ),
                          child: Text(
                            '1283p',
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
                            '총 페이지 수',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.465,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            top: 30,
                          ),
                          child: Text(
                            '45p',
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
                            '오늘 목표',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.465,
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
              padding: EdgeInsets.all(10),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
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
            )
          ],
        ),
      ),
    );
  }
}
