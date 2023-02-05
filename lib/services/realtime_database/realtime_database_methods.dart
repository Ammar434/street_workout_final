import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../models/challenge.dart';
import '../../models/custom_user.dart';
import '../firestore_methods/user_firestore_methods.dart';

// String kChallengeId = "";

class RealtimeDatabaseMethods {
  final FirebaseDatabase _firebaseDatabse = FirebaseDatabase.instance;

  Future<String> addChallenge(Challenge challenge, String path) async {
    String res = "Some error occured";

    try {
      await _firebaseDatabse.ref().child(path).set(challenge.toJson());
      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }

  Future<String> deleteChallengeReference(String path) async {
    String res = "Some error occured";

    try {
      await _firebaseDatabse.ref().child(path).remove();
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    debugPrint("res $res");

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
    required String evaluatorUid,
    required CustomUser challenger,
  }) async {
    String res = "Some error happened";

    try {
      await _firebaseDatabse.ref().child("/${challenger.favoriteParc}/$evaluatorUid").update({
        'challengerUid': challenger.uid,
        "challengerImageUrl": challenger.profileImage,
        "challengerName": challenger.userName,
      });
      res = "success";
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }

  Future<String> getReadyForTheChallenge({
    required bool isChallenger,
    required String path,
    required bool value,
  }) async {
    String res = "Some error happened";

    try {
      if (isChallenger) {
        await _firebaseDatabse.ref().child(path).update({
          'isChallengerReady': value,
        });
      } else {
        await _firebaseDatabse.ref().child(path).update({
          'isEvaluatorReady': value,
        });
      }

      res = "success";
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }

  Future<String> endTheChallenge({required String path, required bool isChallenger}) async {
    String res = "Some error happened";

    try {
      if (isChallenger) {
        await _firebaseDatabse.ref().child(path).update({
          'isChallengeEndChallenger': true,
        });
      } else {
        await _firebaseDatabse.ref().child(path).update({
          'isChallengeEndEvaluator': true,
        });
      }

      res = "success";
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }

  Future<String> writeChallengeId({
    required String path,
    required String challengeId,
  }) async {
    String res = "Some error happened";

    try {
      await _firebaseDatabse.ref().child(path).update({
        "challengeId": challengeId
        // 'isChallengeEnd': true,
        // "repetionRating": repetionRating,
        // "executionRating": executionRating,
      });

      res = "success";
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }

  Future<String> writeChallengeScore({
    required String path,
    required double repetitionRating,
    required double executionRating,
  }) async {
    String res = "Some error happened";

    try {
      await _firebaseDatabse.ref().child(path).update({
        "repetitionRating": repetitionRating,
        "executionRating": executionRating,
      });

      res = "success";
    } catch (error) {
      debugPrint(error.toString());
      res = error.toString();
    }
    return res;
  }
}
