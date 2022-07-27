import 'custom_user.dart';

class Challenge {
  final String challengeId;
  final String challengerUid;
  final String evaluatorUid;
  // final String challengerProfileImage;
  // final String evaluatorProfileImage;
  final String parcId;

  Challenge({
    required this.challengeId,
    required this.challengerUid,
    required this.evaluatorUid,
    required this.parcId,
    // required this.challengerProfileImage,
    // required this.evaluatorProfileImage,
  });
  Map<String, dynamic> toJson() => {
        "challengeId": challengeId,
        "challengerUid": challengerUid,
        "evaluatorUid": evaluatorUid,
        "parcId": parcId,
        // "challengerProfileImage": challengerProfileImage,
        // " evaluatorProfileImage": evaluatorProfileImage,
      };

  static Challenge challengeFromSnapshot(Map<String, dynamic> snapshot) {
    // var snapshot = asyncSnapshot.snapshot.d.data() as ;

    // debugPrint("-----------------------------------------");
    // debugPrint(snapshot.toString());
    // debugPrint("-----------------------------------------");
    return Challenge(
      challengeId: snapshot["challengeId"],
      challengerUid: snapshot["challengerUid"],
      evaluatorUid: snapshot["evaluatorUid"],
      parcId: snapshot["parcId"],
      // evaluatorProfileImage: snapshot["evaluatorProfileImage"],
      // challengerProfileImage: snapshot["challengerProfileImage"],
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
