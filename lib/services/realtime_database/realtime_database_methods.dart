import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/firestore_methods/user_firestore_methods.dart';
import 'package:uuid/uuid.dart';

class RealtimeDatabaseMethods {
  final FirebaseDatabase _firebaseDatabse = FirebaseDatabase.instance;

  Future<String> createParcReference(String parcId, String evaluatorUid) async {
    String res = "Some error occured";

    try {
      Challenge challenge = Challenge(
        challengeId: const Uuid().v1(),
        challengerUid: "",
        evaluatorUid: evaluatorUid,
        parcId: parcId,
        isChallengerReady: false,
        isEvaluatorReady: true,
      );

      await _firebaseDatabse.ref().child("/$parcId/$evaluatorUid").set(challenge.toJson());
      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Future<String> deleteParcReference(String parcId, String evaluatorUid) async {
    String res = "Some error occured";

    try {
      await _firebaseDatabse.ref().child("/$parcId/$evaluatorUid").remove();
      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Stream<List<Challenge>> getChallengeStream(String parcId) {
    final Stream<DatabaseEvent> challengeStream = _firebaseDatabse.ref().child(parcId).onValue;

    final Stream<List<Challenge>> results = challengeStream.map((event) {
      final challengeMap = Map<dynamic, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
      final challengeList = challengeMap.entries.map((e) {
        return Challenge.challengeFromSnapshot(
          Map<String, dynamic>.from(e.value),
        );
      }).toList();
      return challengeList;
    });

    return results;
  }

  Future<List<CustomUser>> getListCustomUser(List<Challenge> listChallenge) async {
    List<CustomUser> list = [];
    try {
      for (int i = 0; i < listChallenge.length; i++) {
        CustomUser c = await UserFirestoreMethods().findUserByUid(listChallenge[i].evaluatorUid);
        list.add(c);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return list;
  }

  Future<String> addChallengerToChallenge({
    required String parcId,
    required String evaluatorUid,
    required String challengerUid,
  }) async {
    String res = "success";

    List<CustomUser> list = [];
    try {
      await _firebaseDatabse.ref().child("/$parcId/$evaluatorUid").update({
        'challengerUid': challengerUid,
      });
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }
}
