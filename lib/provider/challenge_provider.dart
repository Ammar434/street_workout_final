import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

import '../models/challenge.dart';
import '../models/custom_user.dart';
import '../services/realtime_database/realtime_database_methods.dart';

class ChallengeProvider extends ChangeNotifier {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final RealtimeDatabaseMethods realtimeDatabaseMethods = RealtimeDatabaseMethods();
  late StreamSubscription<DatabaseEvent> _streamSubscription;

  late Challenge _challenge;
  Challenge get getChallenge => _challenge;

  ChallengeProvider() {
    initChallenge();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void initChallenge() {
    _challenge = Challenge.initNullChallenge();
    notifyListeners();
  }

  Future<String> updateChallengeId(String id) async {
    _challenge.challengeId = id;
    String res = await writeChallengeToRealtimeDatabase(true);
    notifyListeners();

    return res;
  }

  Future<String> addChallengerValue(CustomUser user, String parcId) async {
    _challenge = Challenge.initNullChallenge();

    _challenge.challengerUid = user.uid;
    _challenge.challengerImageUrl = user.profileImage;
    _challenge.challengerName = user.userName;
    _challenge.parcId = parcId;
    String res = await writeChallengeToRealtimeDatabase(true);
    notifyListeners();

    return res;
  }

  Future<String> addEvaluatorValue(CustomUser user, String parcId) async {
    _challenge = Challenge.initNullChallenge();

    // debugPrint("c ${_challenge.challengerUid}");
    // debugPrint("e ${_challenge.evaluatorUid}");

    _challenge.evaluatorUid = user.uid;
    _challenge.evaluatorImageUrl = user.profileImage;
    _challenge.evaluatorName = user.userName;
    _challenge.parcId = parcId;
    String res = await writeChallengeToRealtimeDatabase(false);
    listenToChallengerSelectEvaluator();

    notifyListeners();

    return res;
  }

  Future<String> writeChallengeToRealtimeDatabase(bool isChallenger) async {
    String res = "Some error occured";
    String path = "/${_challenge.parcId}/evaluator/${_challenge.evaluatorUid}";
    if (isChallenger) {
      path = "/${_challenge.parcId}/challenger/${_challenge.challengerUid}";
    }
    try {
      await realtimeDatabaseMethods.addChallenge(_challenge, path);
      notifyListeners();
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    notifyListeners();

    return res;
  }

  Future<String> deleteRoom(bool isChallenger) async {
    String res = "Some error occured";
    String path = "/${_challenge.parcId}/evaluator/${_challenge.evaluatorUid}";
    if (isChallenger) {
      path = "/${_challenge.parcId}/challenger/${_challenge.challengerUid}";
    }
    try {
      await realtimeDatabaseMethods.deleteChallengeReference(path);
      notifyListeners();
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    notifyListeners();

    return res;
  }

  Future<String> addEvaluatorToChallenge(Challenge challengeEvaluator) async {
    String res = "Some error occured";
    _challenge.evaluatorUid = challengeEvaluator.evaluatorUid;
    _challenge.evaluatorName = challengeEvaluator.evaluatorName;
    _challenge.evaluatorImageUrl = challengeEvaluator.evaluatorImageUrl;

    try {
      // Write for evaluator
      await writeChallengeToRealtimeDatabase(false);

      // Write for challenger

      await writeChallengeToRealtimeDatabase(true);
      listenToChallengerSelectEvaluator();
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    notifyListeners();
    return res;
  }

  Query listenToEvaluator() {
    String s = 'evaluator';
    String path = "/${_challenge.parcId}/$s";
    var ref = databaseReference.child(path);
    return ref;
  }

  void listenToChallengerSelectEvaluator() {
    String path = "/${_challenge.parcId}/evaluator/${_challenge.evaluatorUid}";

    _streamSubscription = databaseReference.child(path).onValue.listen(
      (event) {
        _challenge = Challenge.challengeFromSnapshot(
          event.snapshot.value as Map<dynamic, dynamic>,
        );

        notifyListeners();
      },
    );
  }

  Future<String> getReadyForTheChallenge(bool isChallenger, bool isReady) async {
    String res = "Some error occured";
    try {
      // Write for evaluator
      if (isChallenger) {
        _challenge.isChallengerReady = !(_challenge.isChallengerReady);
      } else {
        _challenge.isEvaluatorReady = !(_challenge.isEvaluatorReady);
      }
      await writeChallengeToRealtimeDatabase(false);
      await writeChallengeToRealtimeDatabase(true);

      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    notifyListeners();

    return res;
  }

  Future<String> endChallenge(bool isChallenger) async {
    String res = "Some error occured";

    String path = "/${_challenge.parcId}/evaluator/${_challenge.evaluatorUid}";

    try {
      res = await realtimeDatabaseMethods.endTheChallenge(
        path: path,
        isChallenger: isChallenger,
      );
    } catch (e) {
      res = e.toString();
    }
    notifyListeners();

    return res;
  }
}
