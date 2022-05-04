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
    DocumentSnapshot<Map<String, dynamic>> snapshot = await ClubCollection.doc(clubId).get();
    print(snapshot.data());
    // 컬렉션의 스냅샷 리스트 조회
    QuerySnapshot<Map<String, dynamic>> snapshot2 =
        await ClubCollection.doc(clubId).collection('members').where('uid', isEqualTo: 'uid111').get();

    // 컬렉션에 스냅샷 추가
    DocumentReference<Map<String, dynamic>> ref = await ClubCollection.add({"uid": "황성현이지롱"});

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
    List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapShotList = snapshot.docs;
    querySnapShotList.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      print(element.data());
    });

    // return snapshot.data();
  }

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
      'today_date': todaygoal,
    });
    notifyListeners(); // 화면 갱신
    return ref.id;
  }

  void createmembers(
    String uid,
    int readpages,
    String docId,
  ) async {
    await ClubCollection.doc(docId).collection('members').add({
      'uid': uid,
      'readpages': readpages,
      'docId': docId,
    });
    notifyListeners();
  }

  // void createFeed(String docId, String uid, int page, bool isprivate, String post, String timestamp) async {
  //   await ClubCollection.doc(docId).collection('members').
  // }

  Future<QuerySnapshot> clubread() async {
    return ClubCollection.get();
  }
}
