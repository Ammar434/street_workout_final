import 'package:cloud_firestore/cloud_firestore.dart';

class CustomUser {
  const CustomUser({
    required this.uid,
    required this.userName,
    required this.profileImage,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.follower,
    required this.following,
    required this.points,
    required this.favoriteParc,
    required this.numberOfContribution,
    required this.numberOfEvaluation,
    required this.instagramProfile,
    required this.rewards,
  });
  final String uid;
  final String userName;
  final String profileImage;
  final String gender;
  final int age;
  final double weight;
  final double height;
  final List follower;
  final List following;
  final int points;
  final String favoriteParc;
  final int numberOfContribution;
  final int numberOfEvaluation;
  final String instagramProfile;
  final List rewards;

  //Pour poster sur firebase en json
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "userName": userName,
        "profileImage": profileImage,
        "gender": gender,
        "age": age,
        "weight": weight,
        "height": height,
        "follower": follower,
        "following": following,
        "points": points,
        "favoriteParc": favoriteParc,
        "numberOfContribution": numberOfContribution,
        "numberOfEvaluation": numberOfEvaluation,
        "instagramProfile": instagramProfile,
        "rewards": rewards,
      };

//Recupere user depuis firebase et le converti en CustomUser
  static CustomUser userFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return CustomUser(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      profileImage: snapshot['profileImage'],
      gender: snapshot['gender'],
      age: snapshot['age'],
      weight: snapshot['weight'],
      height: snapshot['height'],
      follower: snapshot['follower'],
      following: snapshot['following'],
      points: snapshot['points'],
      favoriteParc: snapshot['favoriteParc'],
      numberOfContribution: snapshot['numberOfContribution'],
      numberOfEvaluation: snapshot['numberOfEvaluation'],
      instagramProfile: snapshot['instagramProfile'],
      rewards: snapshot['rewards'],
    );
  }
}
