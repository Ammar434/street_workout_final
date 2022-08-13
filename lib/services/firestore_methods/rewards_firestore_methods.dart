import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';
import 'package:uuid/uuid.dart';

class RewardsFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final UserFirestoreMethods _userFirestoreMethods = UserFirestoreMethods();
  final Uuid _uuid = Uuid();

  Future<void> addRewards(String categorie, int orderNum) async {
    Reward rewards = Reward(
      id: _uuid.v1(),
      title: "title",
      subtitle: "subtitle",
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/streetworkoutfighter.appspot.com/o/rewards%2Fasset_2.png?alt=media&token=2f1900d1-22b5-4651-8f8b-c742a72b6bcb",
      descriptionForChallenger: "descriptionForChallenger",
      descriptionForEvaluator: "descriptionForEvaluator",
    );

    await _firebaseFirestore.collection("rewards").doc(categorie).set({
      "categoryName": categorie[0].toUpperCase() + categorie.substring(1),
      "orderNum": orderNum,
    }).then((value) async {
      await _firebaseFirestore.collection("rewards").doc(categorie).collection("rewardsList").doc(rewards.id).set(
            rewards.toJson(),
          );
    });
  }

  Future<List<RewardsCategory>> getRewardsSnapshot() async {
    List<RewardsCategory> listRewardsCategory = [];
    double offsetFrom = 0;
    final QuerySnapshot<Map<String, dynamic>> rewardQuery = await _firebaseFirestore.collection("rewards").get();

    for (int i = 0; i < rewardQuery.size; i++) {
      final DocumentSnapshot document = rewardQuery.docs.elementAt(i);
      QuerySnapshot<Map<String, dynamic>> rewardQuery2 = await _firebaseFirestore.collection("rewards").doc(rewardQuery.docs.elementAt(i).id).collection("rewardsList").get();

      listRewardsCategory.add(
        RewardsCategory.rewardsCategoryFromSnapshot(document, rewardQuery2),
      );
      if (i > 0) {
        offsetFrom += (listRewardsCategory[i - 1].rewardsList.length) * rewardsTileHeight;
        listRewardsCategory[i].offsetFrom = offsetFrom + (categoryHeight) * i;
      }

      if (i < rewardQuery.size - 1) {
        listRewardsCategory[i].offsetTo = offsetFrom + (listRewardsCategory[i].rewardsList.length + 1) * rewardsTileHeight;
      } else {
        listRewardsCategory[i].offsetTo = double.infinity;
      }
    }

    return listRewardsCategory;
  }

  Future<RewardsCategory> getRewardsStrengthSnapshot() async {
    late RewardsCategory rewardsStrengthCategory;
    final DocumentSnapshot<Map<String, dynamic>> rewardQuery = await _firebaseFirestore.collection("rewards").doc("strength").get();
    final QuerySnapshot<Map<String, dynamic>> rewardQuery2 = await _firebaseFirestore.collection("rewards").doc("strength").collection("rewardsList").get();

    rewardsStrengthCategory = RewardsCategory.rewardsCategoryFromSnapshot(rewardQuery, rewardQuery2);

    return rewardsStrengthCategory;
  }

  Future<Reward> getRewardsById(String rewardId) async {
    late Reward reward;
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore.collection("rewards").doc("strength").collection("rewardsList").doc(rewardId).get();

    reward = Reward.rewardsFromSnapshot(snapshot.data() as Map<String, dynamic>);

    return reward;
  }
}
