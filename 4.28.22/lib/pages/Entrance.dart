import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Lobby.dart';
import 'Lobby_members.dart';
import 'auth_service.dart';
import 'bookclub_service.dart';
import 'create_club.dart';

class EntrancePage extends StatelessWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _codecontroller = TextEditingController();
    return Consumer<AuthService>(builder: (context, authService, child) {
      final authService = context.read<AuthService>();
      final user = authService.currentUser()!;
      return Consumer<ClubService>(
        builder: (context, clubService, child) {
          return SafeArea(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateClub(),
                            ),
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
                                hintText: '영문,숫자 20자리 조합',
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
                            onPressed: () async {
                              List docIdList = await clubService.getClubList();
                              if (docIdList.contains(_codecontroller.text)) {
                                clubService.updateuserdocId(
                                    user.uid, _codecontroller.text);

                                clubService.createmembers(
                                    user.uid, _codecontroller.text);

                                clubService.read_page_update(user.uid,
                                    _codecontroller.text as String, '0');

                                DocumentSnapshot<Map<String, dynamic>> docsnap =
                                    await clubService.ClubCollection.doc(
                                            _codecontroller.text)
                                        .get();

                                //splash에서 null인 authservice의 변수들 지정
                                authService.totalpage =
                                    docsnap.data()?['total_pages'];
                                authService.readpage = docsnap
                                    .data()?['member_readpages'][user.uid];

                                authService.docId = _codecontroller.text;
                                authService.goaldate =
                                    docsnap.data()?['goal_date'];
                                authService.todaygoal =
                                    docsnap.data()?['today_goal'];

                                authService.bookname =
                                    docsnap.data()?['bookname'];
                                authService.leader = docsnap.data()?['leader'];

                                // authService.rank = ;
                                Provider.of<AuthService>(context, listen: false)
                                    .rank = await Provider.of<ClubService>(
                                        context,
                                        listen: false)
                                    .get_my_rank(authService.docId, user.uid);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Lobby_mem(docId: _codecontroller.text),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('초대코드를 다시 입력하세요')));
                              }
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
                            icon:
                                Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        height: 10.0,
                        width: 500.0,
                        color: Colors.black,
                      ),
                      // Text(
                      //   '초대 번호를 다시 확인해주세요.',
                      //   style: TextStyle(
                      //     color: Colors.red,
                      //     fontSize: 10,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
