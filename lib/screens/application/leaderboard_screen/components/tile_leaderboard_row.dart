import 'package:flutter/material.dart';
import "../../../../common_libs.dart";

import '../../../../models/leaderboard.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';
import '../../profile_screen/profile_screen.dart';

class TileLeaderboardRow extends StatelessWidget {
  const TileLeaderboardRow({
    Key? key,
    required this.index,
    this.gradient,
    required this.leaderboard,
  }) : super(key: key);
  final int index;
  final Leaderboard leaderboard;
  final LinearGradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSmallPaddingValue * 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userUid: leaderboard.userId,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Text(
              index.toString(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: kPaddingValue,
            ),
            RoundedCircleUserProfileWidget(
              gradient: gradient,
              radius: kRadiusValue * 2.5,
              imageUrl: leaderboard.userProfileImage,
            ),
            SizedBox(
              width: kPaddingValue,
            ),
            SizedBox(
              // width: 100,
              child: Text(
                leaderboard.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Text(
              (leaderboard.userPoint + leaderboard.numberOfContribution + leaderboard.numberOfEvaluation).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
