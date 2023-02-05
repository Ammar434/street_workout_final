import 'package:cloud_firestore/cloud_firestore.dart';

class RewardsCategory {
  final String name;
  final List<Reward> rewardsList;
  double offsetFrom;
  double offsetTo;
  RewardsCategory({
    required this.name,
    required this.rewardsList,
    required this.offsetFrom,
    required this.offsetTo,
  });
  static RewardsCategory rewardsCategoryFromSnapshot(DocumentSnapshot documentSnapshot, QuerySnapshot querySnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;

    List<Reward> listRewards = [];

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      listRewards.add(Reward.rewardsFromSnapshot(documentSnapshot.data() as Map<String, dynamic>));
    }

    return RewardsCategory(
      name: snapshot['categoryName'],
      rewardsList: listRewards,
      offsetFrom: 0.0,
      offsetTo: 0,
    );
  }
}

class Reward {
  Reward({
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
  final List descriptionForChallenger;
  final List descriptionForEvaluator;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "descriptionForChallenger": descriptionForChallenger,
        "descriptionForEvaluator": descriptionForEvaluator,
      };

//Recupere user depuis firebase et le converti en CustomUser
  static Reward rewardsFromSnapshot(Map<String, dynamic> snapshot) {
    // var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Reward(
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
