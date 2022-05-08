import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Entrance.dart';
import 'Lobby.dart';
import 'auth_service.dart';
import 'bookclub_service.dart';
import 'lobby_members.dart';

void main() {
  runApp(SplashPage());
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        //uid 저장하기
        Provider.of<AuthService>(context, listen: false).uid =
            Provider.of<AuthService>(context, listen: false).currentUser()?.uid;
        String? currentuid =
            Provider.of<AuthService>(context, listen: false).uid;

        /////////////////
        //docId 저장하기
        QuerySnapshot<Map<String, dynamic>> document =
            await Provider.of<ClubService>(context, listen: false)
                .UserCollection
                .where('uid',
                    isEqualTo:
                        Provider.of<AuthService>(context, listen: false).uid)
                .get();
        Provider.of<AuthService>(context, listen: false).docId =
            document.docs[0]['docId'];

        String? currentdocId =
            Provider.of<AuthService>(context, listen: false).docId;

        ////
        ///leader의 uid값 가져오기

        DocumentSnapshot<Map<String, dynamic>> docuref =
            await Provider.of<ClubService>(context, listen: false)
                .ClubCollection
                .doc(currentdocId)
                .get();
        String? currentleaderuid = docuref.data()?['leader'];

        ////page 있는 경우 페이지 불러오기
        Provider.of<AuthService>(context, listen: false).totalpage =
            docuref.data()?['total_pages'];
        //오늘 목표
        Provider.of<AuthService>(context, listen: false).todaygoal =
            docuref.data()?['today_goal'];
        // 목표 날짜
        Provider.of<AuthService>(context, listen: false).goaldate =
            docuref.data()?['goal_date'];
        Provider.of<AuthService>(context, listen: false).bookname =
            docuref.data()?['bookname'];

        if (currentdocId != 'unavailable') {
          if (currentuid == currentleaderuid) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LobbyPage(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Lobby_mem(
                  docId: currentdocId,
                ),
              ),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EntrancePage()),
          );
        }
      },
    );

/////////////////////
    // Timer(
    //   Duration(seconds: 3),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoginPage(),
    //     ),
    //   ),
    // );

    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Consumer<ClubService>(
          builder: (context, clubService, child) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  Container(
                    height: 20.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Image.asset(
                    'lib/images/run.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'lib/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 10.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Container(
                    height: 10.0,
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
                    height: 30.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Container(
                    height: 40.0,
                    width: 180.0,
                    color: Colors.grey[900],
                    child: Center(
                      child: Text(
                        '앱에 접속 중입니다.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
