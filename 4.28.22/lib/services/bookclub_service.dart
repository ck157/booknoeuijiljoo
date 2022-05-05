import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//구현 기능
// read_post : 포스트 불러오기
// create_post : 글 작성하기
// create_comment : 댓글 작성하기
// update_page : 페이지 수 업데이트
// delete_post : 글 삭제하기
// delete_comment : 댓글 삭제하기

class ClubService extends ChangeNotifier {
  final ClubCollection = FirebaseFirestore.instance.collection('Book');
  // final membersCollection = FirebaseFirestore.instance.collection('clubs').doc();

  getClub(String clubId) async {
    // 단하나의 스냅샷 조회
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await ClubCollection.doc(clubId).get();
    print(snapshot.data());
    // 컬렉션의 스냅샷 리스트 조회
    QuerySnapshot<Map<String, dynamic>> snapshot2 =
        await ClubCollection.doc(clubId)
            .collection('members')
            .where('uid', isEqualTo: 'uid111')
            .get();

    // 컬렉션에 스냅샷 추가
    DocumentReference<Map<String, dynamic>> ref =
        await ClubCollection.add({"uid": "황성현이지롱"});

    inspect(ref);
    print('ID?????${ref.id}');

    // print('snapshot2 Exist? ${snapshot2.docs.length}');
    // snapshot2.docs.forEach((element) {
    //   print(element.data());
    // });

    return snapshot.data();
  }

  getClubList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await ClubCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapShotList =
        snapshot.docs;
    querySnapShotList
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      print(element.data());
    });
    // return snapshot.data();
  }

  Future<QuerySnapshot> getdocId(String uid) async {
    // QuerySnapshot<Map<String, dynamic>>
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await ClubCollection.where('leader', isEqualTo: uid).get();
    return snapshot;
  }
  //페이지를 불러올 때 document의 id값이 불러와져야함. 그런데 그 전페이지 없이
  //바로 이 페이지로 라우팅 될 수도 있음.
  //그럼 어떻게 해야하는가??

  Future<String> create_club(
    String name,
    String leader,
    //초기에 지정 안되는 값
    String clubrule,
    String goaldate,
    String totalpages,
    String todaygoal,
  ) async {
    // post 작성하기
    DocumentReference<Map<String, dynamic>> ref = await ClubCollection.add({
      'name': name,
      'leader': leader,
      //초기에 저장 안되는 값
      'club_rule': clubrule,
      'goal_date': goaldate,
      'total_pages': totalpages,
      'today_goal': todaygoal,
    });
    notifyListeners(); // 화면 갱신
    return ref.id;
  }

  //docId를 추가해주는 함수.(방 생성시)
  void add_docId(
    String docId,
  ) async {
    await ClubCollection.doc(docId).update({
      'docId': docId,
    });
  }

  void createmembers(
    String uid,
    int readpages,
    String docId,
  ) async {
    await ClubCollection.doc(docId).collection('members').add({
      'uid': uid,
      'readpages': readpages,
    });
    notifyListeners();
  }

//lobby에서 토탈페이지 업데이트
  void total_page_update(
    String docId,
    String page,
  ) async {
    await ClubCollection.doc(docId).update(
      {'total_pages': page},
    );
  }

//lobby에서 오늘 목표 업데이트
  void today_page_update(
    String docId,
    String page,
  ) async {
    await ClubCollection.doc(docId).update(
      {'today_goal': page},
    );
  }

  Future<String> gettotalpages(String docId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await ClubCollection.doc(docId).get();
    return snapshot.data()!['total_pages'];
  }

  // 업뎃하고, 초깃값이 아니라면 textfield가 아니라 text를 띄워주는 방향으로
  //근데 수정 가능하게는 어떻게 하지??

  // void createFeed(String docId, String uid, int page, bool isprivate, String post, String timestamp) async {
  //   await ClubCollection.doc(docId).collection('members').
  // }

  Future<QuerySnapshot> clubread() async {
    return ClubCollection.get();
  }

  void create_post(String text, String uid, String num) async {
    // post 작성하기
    await ClubCollection.add({
      'uid': uid, // 유저 식별자
      'post': text, // 포스트 작성
      'page': num, // 페이지 수
      'isPrivate': false, // 완료 여부
    });
    notifyListeners(); // 화면 갱신
  }
}
