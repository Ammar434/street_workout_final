import 'custom_user.dart';

class Challenge {
  final String challengeId;
  final String challengerUid;
  final String evaluatorUid;
  final String parcId;
  final bool isChallengerReady;
  final bool isEvaluatorReady;

  Challenge({
    required this.challengeId,
    required this.challengerUid,
    required this.evaluatorUid,
    required this.parcId,
    required this.isChallengerReady,
    required this.isEvaluatorReady,
  });
  Map<String, dynamic> toJson() => {
        "challengeId": challengeId,
        "challengerUid": challengerUid,
        "evaluatorUid": evaluatorUid,
        "parcId": parcId,
        "isChallengerReady": isChallengerReady,
        "isEvaluatorReady": isEvaluatorReady,
      };

  static Challenge challengeFromSnapshot(Map<String, dynamic> snapshot) {
    return Challenge(
      challengeId: snapshot["challengeId"],
      challengerUid: snapshot["challengerUid"],
      evaluatorUid: snapshot["evaluatorUid"],
      parcId: snapshot["parcId"],
      isChallengerReady: snapshot["isChallengerReady"],
      isEvaluatorReady: snapshot["isEvaluatorReady"],
    );
  }
}

class ChallengeWithCustomUser {
  final CustomUser? challenger;
  final CustomUser? evaluator;
  final String challengeId;
  final String challengerUid;
  final String evaluatorUid;
  final String parcId;
  ChallengeWithCustomUser({
    required this.evaluatorUid,
    required this.parcId,
    required this.evaluator,
    required this.challenger,
    required this.challengeId,
    required this.challengerUid,
  });

  // Future<ChallengeWithCustomUser> challengeFromSnapshot(Map<String, dynamic> snapshot) async {
  //   CustomUser? e = await UserFirestoreMethods().findUserByUid(evaluatorUid);
  //   CustomUser? c;
  //   return ChallengeWithCustomUser(
  //     evaluatorUid: snapshot["evaluatorUid"],
  //     challengerUid: snapshot["challengerUid"],
  //     challenger: c,
  //     evaluator: e,
  //     challengeId: snapshot["challengeId"],
  //     parcId: snapshot["parcId"],
  //   );
  // }
}
