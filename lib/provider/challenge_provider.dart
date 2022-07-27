import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';

class ChallengeProvider extends ChangeNotifier {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  List<Challenge> _listChallenge = [];
  late StreamSubscription<DatabaseEvent> _streamSubscription;

  List<Challenge> get listChallenge => _listChallenge;

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  final CustomUser evaluator;
  ChallengeProvider({required this.evaluator}) {
    _listenToListChallenge();
  }

  Future<void> _listenToListChallenge() async {
    _streamSubscription = _databaseReference.child(evaluator.favoriteParc).onValue.listen((event) async {
      final challengeMap = Map<dynamic, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);

      // for (int i = 0; i < challengeMap.length; i++) {
      //   CustomUser? evaluator = await UserFirestoreMethods().findUserByUid(challengeMap.values.elementAt(i)['evaluatorUid']);
      //   CustomUser? challenger = await UserFirestoreMethods().findUserByUid(challengeMap.values.elementAt(i)['challengerUid']);
      //   ChallengeWithCustomUser c = ChallengeWithCustomUser(
      //     evaluatorUid: challengeMap.values.elementAt(i)['evaluatorUid'],
      //     parcId: challengeMap.values.elementAt(i)['parcId'],
      //     evaluator: evaluator,
      //     challenger: challenger,
      //     challengeId: challengeMap.values.elementAt(i)['challengeId'],
      //     challengerUid: challengeMap.values.elementAt(i)['challengerUid'],
      //   );
      //   _listChallenge.add(c);
      //   notifyListeners();
      // }
      _listChallenge = challengeMap.values.map((e) {
        return Challenge.challengeFromSnapshot(Map<String, dynamic>.from(e));
      }).toList();
      notifyListeners();
    });
  }

  // void removeListChallenge() {
  //   debugPrint("a-----------------------------------------");
  //   debugPrint("v-----------------------------------------");
  //   debugPrint("d-----------------------------------------");
  //   debugPrint(evaluator.favoriteParc.toString());
  //   debugPrint(evaluator.uid.toString());
  //   debugPrint("-----------------------------------------");
  //   RealtimeDatabaseMethods().deleteParcReference(evaluator.favoriteParc, evaluator.uid);
  //   notifyListeners();
  // }
}
