class Challenge {
  String challengeId;
  String challengerUid;
  String challengerImageUrl;
  String challengerName;
  String evaluatorUid;
  String evaluatorName;
  String evaluatorImageUrl;

  String parcId;
  bool isChallengerReady;
  bool isEvaluatorReady;
  bool isChallengeEndEvaluator;
  bool isChallengeEndChallenger;
  double repetitionRating;
  double executionRating;

  Challenge({
    required this.challengeId,
    required this.challengerUid,
    required this.evaluatorUid,
    required this.parcId,
    required this.isChallengerReady,
    required this.isEvaluatorReady,
    required this.challengerImageUrl,
    required this.challengerName,
    required this.evaluatorName,
    required this.evaluatorImageUrl,
    required this.isChallengeEndEvaluator,
    required this.isChallengeEndChallenger,
    required this.repetitionRating,
    required this.executionRating,
  });

  static Challenge initNullChallenge() {
    return Challenge(
      challengeId: "",
      challengerUid: "",
      evaluatorUid: "",
      parcId: "",
      isChallengerReady: false,
      isEvaluatorReady: false,
      challengerImageUrl: "",
      challengerName: "",
      evaluatorName: "",
      evaluatorImageUrl: "",
      isChallengeEndEvaluator: false,
      isChallengeEndChallenger: false,
      repetitionRating: -1.0,
      executionRating: -1.0,
      // evaluatorAvailable: [],
    );
  }

  Map<String, dynamic> toJson() => {
        "challengeId": challengeId,
        "challengerUid": challengerUid,
        "challengerName": challengerName,
        "challengerImageUrl": challengerImageUrl,
        "evaluatorUid": evaluatorUid,
        "evaluatorName": evaluatorName,
        "evaluatorImageUrl": evaluatorImageUrl,
        "parcId": parcId,
        "isChallengerReady": isChallengerReady,
        "isEvaluatorReady": isEvaluatorReady,
        "repetitionRating": repetitionRating,
        "executionRating": executionRating,
        "isChallengeEndEvaluator": isChallengeEndEvaluator,
        "isChallengeEndChallenger": isChallengeEndChallenger,
        // "evaluatorAvailable": evaluatorAvailable,
      };

  static Challenge challengeFromSnapshot(Map<dynamic, dynamic> snapshot) {
    return Challenge(
        challengeId: snapshot["challengeId"],
        challengerUid: snapshot["challengerUid"],
        challengerName: snapshot["challengerName"],
        challengerImageUrl: snapshot["challengerImageUrl"],
        evaluatorUid: snapshot["evaluatorUid"],
        evaluatorName: snapshot["evaluatorName"],
        evaluatorImageUrl: snapshot["evaluatorImageUrl"],
        parcId: snapshot["parcId"],
        isChallengerReady: snapshot["isChallengerReady"],
        isEvaluatorReady: snapshot["isEvaluatorReady"],
        isChallengeEndEvaluator: snapshot['isChallengeEndEvaluator'],
        repetitionRating: snapshot["repetitionRating"],
        executionRating: snapshot["executionRating"],
        isChallengeEndChallenger: snapshot["isChallengeEndChallenger"]
        // evaluatorAvailable: snapshot["evaluatorAvailable"]
        );
  }
}
