import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/custom_user.dart';
import '../../models/rewards.dart';
import '../../screens/application/achievement_screen/achievement_screen.dart';

class RewardsFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final UserFirestoreMethods _userFirestoreMethods = UserFirestoreMethods();
  final Uuid _uuid = const Uuid();

  Future<String> addRewards(
    String title,
    String categorie,
    String imagePath,
    List<String> description,
    bool isAdmin,
  ) async {
    Reward rewards = Reward(
      id: _uuid.v1(),
      title: title,
      imageUrl: imagePath,
      description: description,
      isPublish: isAdmin,
    );
    String res = "Some error occurred";
    try {
      await _firebaseFirestore.collection("rewards").doc(categorie.toLowerCase()).collection("rewardsList").doc(rewards.id).set(
            rewards.toJson(),
          );
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
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

  Future<List<Reward>> getAllRewardsOfAUser(CustomUser user) async {
    List<Reward> rewardList = [];

    try {
      for (String rewardId in user.rewards) {
        Reward reward = await getRewardsById(rewardId);
        rewardList.add(reward);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return rewardList;
  }
}
