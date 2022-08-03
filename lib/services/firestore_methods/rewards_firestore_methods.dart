import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';
import 'package:street_workout_final/services/firestore_methods/user_firestore_methods.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:uuid/uuid.dart';

class RewardsFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final UserFirestoreMethods _userFirestoreMethods = UserFirestoreMethods();
  final Uuid _uuid = const Uuid();

  Future<void> addRewards(String categorie) async {
    Rewards rewards = Rewards(
      id: _uuid.v4(),
      title: "title",
      subtitle: "subtitle",
      // categorie: categorie,
      imageUrl: "https://firebasestorage.googleapis.com/v0/b/streetworkoutfighter.appspot.com/o/rewards%2Fasset_2.png?alt=media&token=2f1900d1-22b5-4651-8f8b-c742a72b6bcb",
      descriptionForChallenger: "descriptionForChallenger",
      descriptionForEvaluator: "descriptionForEvaluator",
    );

    await _firebaseFirestore.collection("rewards").doc(categorie).update({
      "categoryName": categorie[0].toUpperCase() + categorie.substring(1),
      "rewardsList": FieldValue.arrayUnion([rewards.toJson()]),
    });
  }

  Future<List<RewardsCategory>> getRewardsSnapshot() async {
    List<RewardsCategory> listRewardsCategory = [];
    double offsetFrom = 0;
    final QuerySnapshot<Map<String, dynamic>> rewardQuery = await _firebaseFirestore.collection("rewards").get();

    for (int i = 0; i < rewardQuery.size; i++) {
      final DocumentSnapshot document = rewardQuery.docs.elementAt(i);
      listRewardsCategory.add(
        RewardsCategory.rewardsCategoryFromSnapshot(document),
      );
      if (i > 0) {
        offsetFrom += (listRewardsCategory[i - 1].rewards.length + 1) * rewardsTileHeight + (categoryHeight + kPaddingValue * 2) * i;
        listRewardsCategory[i].offsetFrom = offsetFrom;
      }
      debugPrint('éammae${rewardQuery.size}');

      if (i < rewardQuery.size - 1) {
        listRewardsCategory[i].offsetTo = offsetFrom + (listRewardsCategory[i].rewards.length + 1) * rewardsTileHeight;
      } else {
        listRewardsCategory[i].offsetTo = double.infinity;
      }
    }

    // debugPrint(listRewardsCategory[0].name.toString());

    // rewardStream.forEach((element) {
    //   final document = element.docs.elementAt(index)

    //   element.docs.first.
    // });

    return listRewardsCategory;
  }
}
