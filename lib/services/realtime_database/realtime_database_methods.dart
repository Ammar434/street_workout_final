import 'package:uuid/uuid.dart';

class RealtimeDatabaseMethods {
  final FirebaseDatabase _firebaseDatabse = FirebaseDatabase.instance;

  Future<String> createParcReference(String parcId, String evaluatorUid) async {
    String res = "Some error occured";

    try {
      _firebaseDatabse.ref("$parcId/$evaluatorUid").update(
        {
          "parcId": parcId,
          "challengeId": const Uuid().v1(),
          "challengerId": '',
          "evaluatorId": evaluatorUid,
          "isChallengeSuccessed": null,
        },
      );
      res = "success";
    } catch (error) {
      res = error.toString();
    }

    return res;
  }
}
