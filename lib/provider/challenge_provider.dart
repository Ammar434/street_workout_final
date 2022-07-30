import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';

class ChallengeProvider extends ChangeNotifier {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final RealtimeDatabaseMethods realtimeDatabaseMethods = RealtimeDatabaseMethods();
  late StreamSubscription<DatabaseEvent> _streamSubscription;

  bool? _isRoomEmpty;
  bool get isRoomEmpty => _isRoomEmpty!;
  late Challenge _challenge;
  Challenge get getChallenge => _challenge;

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  final CustomUser evaluator;
  ChallengeProvider({required this.evaluator}) {
    // _listenToRoomComplete();
    // _listenToRoomDelete();
  }

  Future<void> listenToRoomComplete() async {
    String path = "${evaluator.favoriteParc}/${evaluator.uid}";

    _streamSubscription = _databaseReference.child(path).onValue.listen(
      (event) {
        if (!event.snapshot.exists) {
          _isRoomEmpty = true;
        } else {
          final challengeMap = Map<dynamic, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
          Map<dynamic, dynamic> map = challengeMap;
          String s = map['challengerUid'];

          _isRoomEmpty = s == "";
        }
        notifyListeners();
      },
    );
  }

  Future<void> writeChallegerUidToRealtimeDatabase({
    required CustomUser currentUserAsChallenger,
    required String evaluatorReference,
  }) async {
    String path = "${currentUserAsChallenger.favoriteParc}/$evaluatorReference";
    await realtimeDatabaseMethods.addChallengerToChallenge(
      evaluatorUid: evaluatorReference,
      challenger: currentUserAsChallenger,
    );
    _isRoomEmpty = false;
    notifyListeners();
  }

  Future<void> deleteRoom(CustomUser evaluator) async {
    // String path = "${evaluator.favoriteParc}/${evaluator.uid}";
    await realtimeDatabaseMethods.deleteParcReference(
      evaluator.favoriteParc,
      evaluator.uid,
    );

    notifyListeners();
  }

  Future<void> listenToChallenge() async {
    _streamSubscription = _databaseReference.child(evaluator.favoriteParc).onValue.listen((event) async {
      final challengeMap = Map<dynamic, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);

      Map<dynamic, dynamic> m = challengeMap.values.elementAt(0) as Map<dynamic, dynamic>;
      Challenge challenge = Challenge.challengeFromSnapshot(m);
      _challenge = challenge;

      notifyListeners();
    });
  }

  Future<void> getReadyForTheChallenge({
    required bool isEvaluator,
    required String path,
  }) async {
    // String path = "${_challenge.parcId}/${_challenge.evaluatorUid}";
    debugPrint("path$path");
    await realtimeDatabaseMethods.getReadyForTheChallenge(
      isEvaluator: isEvaluator,
      path: path,
      value: isEvaluator ? !_challenge.isEvaluatorReady : !_challenge.isChallengerReady,
    );

    notifyListeners();
  }
}
