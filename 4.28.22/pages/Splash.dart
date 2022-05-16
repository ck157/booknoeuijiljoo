import 'dart:async';
import 'dart:developer';

import 'package:booknoejilju/pages/Lobby.dart';
import 'package:booknoejilju/pages/Lobby_members.dart';
import 'package:booknoejilju/services/auth_service.dart';
import 'package:booknoejilju/services/bookclub_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Entrance.dart';
import 'LoginPage.dart';

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
////
        CollectionReference<Map<String, dynamic>> memref =
            Provider.of<ClubService>(context, listen: false)
                .ClubCollection
                .doc(currentdocId)
                .collection('members');

        memref.get().then(
          (querySnapshot) {
            querySnapshot.docs.forEach(
              (document) async {
                if (document.data()['uid'] == currentuid) {
                  DocumentSnapshot<Map<String, dynamic>> memdocref =
                      await Provider.of<ClubService>(context, listen: false)
                          .ClubCollection
                          .doc(currentdocId)
                          .collection('members')
                          .doc(document.id)
                          .get();

                  Provider.of<AuthService>(context, listen: false).readpage =
                      memdocref.data()?['readpages'];
                }
              },
            );
          },
        );
////

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

        if (currentuid == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else if (currentdocId != 'unavailable') {
          if (currentuid == currentleaderuid) {
            Timer(
                Duration(seconds: 3),
                (() => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LobbyPage(),
                      ),
                    )));
          } else {
            // Provider.of<ClubService>(context)
            //     .createmembers(currentuid, currentdocId as String);
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
    Timer(Duration(seconds: 10), () {
      print('timer finished');
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore
            .instance
            .collection('Book')
            .doc(Provider.of<AuthService>(context, listen: false).docId)
            .collection('members')
            .where('uid',
                isEqualTo: Provider.of<AuthService>(context, listen: false).uid)
            .get();

        DocumentSnapshot<Map<String, dynamic>> docusnap =
            await FirebaseFirestore.instance
                .collection('Book')
                .doc(Provider.of<AuthService>(context, listen: false).docId)
                .collection('members')
                .doc(query.docs[0].id)
                .get();

        Provider.of<AuthService>(context, listen: false).rank =
            docusnap.data()?['rank'] ?? 0;
      },
    );

    super.didChangeDependencies();
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
                    height: 150.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Container(
                    child: Image.asset('lib/images/Splash_Character.png'),
                    height: 180.0,
                    width: 400.0,
                  ),
                  Container(
                    height: 25.0,
                    width: 500.0,
                    color: Colors.black,
                  ),
                  Text(
                    '북노의 질주',
                    style: TextStyle(
                        fontFamilyFallback: ['CookieRun'],
                        fontSize: 48.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 12.0,
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}
