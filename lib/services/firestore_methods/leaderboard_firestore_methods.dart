import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/custom_user.dart';
import '../../models/leaderboard.dart';

class LeaderboardFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionPath = "leaderboard";
  final String _documentPath = "leaderboard_document";
  Future<void> addLeadearboard(CustomUser user) async {
    Leaderboard leaderboard = Leaderboard(
      userId: user.uid,
      userName: user.userName,
      userProfileImage: user.profileImage,
      userPoint: user.points,
      userPointWeek: 0,
      userPointDay: 0,
      userPointMonth: 0,
      userPointYear: 0,
    );

    await _firebaseFirestore.collection(_collectionPath).doc(_documentPath).update({
      "list": FieldValue.arrayUnion([leaderboard.toJson()])
    });
  }

  Future<List<Leaderboard>> leaderboardList(String categorie) async {
    List<Leaderboard> leaderboardList = [];
    DocumentSnapshot documentSnapshot = await _firebaseFirestore.collection(_collectionPath).doc(_documentPath).get();
    debugPrint("hello");

    List list = documentSnapshot['list'] as List;

    for (int i = 0; i < list.length; i++) {
      leaderboardList.add(Leaderboard.leaderboardFromSnapshot(list[i]));
    }
    debugPrint("hello${leaderboardList.length}");

    if (categorie == "day") leaderboardList.sort((a, b) => b.userPointDay.compareTo(a.userPointDay));
    if (categorie == "week") leaderboardList.sort((a, b) => b.userPointWeek.compareTo(a.userPointWeek));
    if (categorie == "month") leaderboardList.sort((a, b) => b.userPointMonth.compareTo(a.userPointMonth));
    if (categorie == "year") leaderboardList.sort((a, b) => b.userPointYear.compareTo(a.userPointYear));
    return leaderboardList;
  }
}
