import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RewardsCategory {
  final String name;
  final List<Rewards> rewards;
  double offsetFrom;
  double offsetTo;
  RewardsCategory({
    required this.name,
    required this.rewards,
    required this.offsetFrom,
    required this.offsetTo,
  });
  static RewardsCategory rewardsCategoryFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    double offsetFrom = 0.0;
    debugPrint(snapshot['rewardsList'].length.toString());
    List listFromSnapshot = snapshot['rewardsList'] as List;

    int length = (snapshot['rewardsList'] as List).length;
    List<Rewards> listRewards = [];

    for (int i = 0; i < length; i++) {
      listRewards.add(
        Rewards.rewardsFromSnapshot(listFromSnapshot[i]),
      );
    }
    return RewardsCategory(
      name: snapshot['categoryName'],
      rewards: listRewards,
      offsetFrom: offsetFrom,
      offsetTo: 0,
    );
  }
}

class Rewards {
  Rewards({
    required this.id,
    required this.title,
    required this.subtitle,
    // required this.categorie,
    required this.imageUrl,
    required this.descriptionForChallenger,
    required this.descriptionForEvaluator,
  });

  final String id;
  final String title;
  final String subtitle;
  // final String categorie;
  final String imageUrl;
  final String descriptionForChallenger;
  final String descriptionForEvaluator;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        // "categorie": categorie,
        "imageUrl": imageUrl,
        "descriptionForChallenger": descriptionForChallenger,
        "descriptionForEvaluator": descriptionForEvaluator,
      };

//Recupere user depuis firebase et le converti en CustomUser
  static Rewards rewardsFromSnapshot(Map<String, dynamic> snapshot) {
    // var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Rewards(
      id: snapshot["id"],
      title: snapshot["title"],
      subtitle: snapshot["subtitle"],
      // categorie: snapshot["categorie"],
      imageUrl: snapshot["imageUrl"],
      descriptionForChallenger: snapshot["descriptionForChallenger"],
      descriptionForEvaluator: snapshot["descriptionForEvaluator"],
    );
  }
}
