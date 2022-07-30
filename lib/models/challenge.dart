class Challenge {
  final String challengeId;
  final String challengerUid;
  final String challengerName;
  final String challengerImageUrl;
  final String evaluatorUid;
  final String evaluatorName;
  final String evaluatorImageUrl;

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
    required this.challengerImageUrl,
    required this.challengerName,
    required this.evaluatorName,
    required this.evaluatorImageUrl,
  });
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
    );
  }
}
