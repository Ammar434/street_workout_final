import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard {
  final String userId;
  final String userName;
  final String userProfileImage;
  final int numberOfEvaluation;
  final int numberOfContribution;
  final int userPoint;

  Leaderboard({
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.userPoint,
    required this.numberOfContribution,
    required this.numberOfEvaluation,
  });

  static Leaderboard leaderboardFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Leaderboard(
      userId: snapshot['uid'],
      userName: snapshot['userName'],
      userProfileImage: snapshot['profileImage'],
      userPoint: snapshot['points'],
      numberOfContribution: snapshot['numberOfContribution'],
      numberOfEvaluation: snapshot['numberOfEvaluation'],
    );
  }
}
