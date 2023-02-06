class Leaderboard {
  final String userId;
  final String userName;
  final String userProfileImage;
  final int userPoint;
  // final int userPointDay;
  // final int userPointWeek;
  // final int userPointMonth;
  // final int userPointYear;

  Leaderboard({
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.userPoint,
    // required this.userPointWeek,
    // required this.userPointDay,
    // required this.userPointMonth,
    // required this.userPointYear,
  });

  // Map<String, dynamic> toJson() => {
  //       "userId": userId,
  //       "userName": userName,
  //       "userProfileImage": userProfileImage,
  //       "userPoint": userPoint,

  //       // "userPointDay": userPointDay,
  //       // "userPointWeek": userPointWeek,
  //       // "userPointMonth": userPointMonth,
  //       // "userPointYear": userPointYear,
  //     };

  static Leaderboard leaderboardFromSnapshot(Map<String, dynamic> snapshot) {
    // var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Leaderboard(
      userId: snapshot['userId'], userName: snapshot['userName'], userProfileImage: snapshot['userProfileImage'], userPoint: snapshot['userPoint'],
      // userPointDay: snapshot['userPointDay'],
      // userPointWeek: snapshot['userPointWeek'],
      // userPointMonth: snapshot['userPointMonth'],
      // userPointYear: snapshot['userPointYear'],
    );
  }
}
