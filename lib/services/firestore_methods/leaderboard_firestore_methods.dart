import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionPath = "leaderboard";
  final String _documentPath = "leaderboard_document";

  Future<Duration> timeLeft() async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore.collection(_collectionPath).doc(_documentPath).get();

    Timestamp timestamp = documentSnapshot["timeLeft"] as Timestamp;
    DateTime dateTimeEnd = timestamp.toDate();
    DateTime dateTimeNow = Timestamp.now().toDate();
    Duration d = dateTimeEnd.difference(dateTimeNow);
    return d;
  }

  // Future<List<Leaderboard>> leaderboardList() async {
  //   List<Leaderboard> leaderboardList = [];
  //   DocumentSnapshot documentSnapshot = await _firebaseFirestore.collection(_collectionPath).doc(_documentPath).get();

  //   List list = documentSnapshot['list'] as List;

  //   for (int i = 0; i < list.length; i++) {
  //     leaderboardList.add(Leaderboard.leaderboardFromSnapshot(list[i]));
  //   }

  //   return leaderboardList;
  // }
}
