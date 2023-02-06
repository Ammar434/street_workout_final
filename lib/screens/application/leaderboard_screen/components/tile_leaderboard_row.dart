import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../models/leaderboard.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';

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
      padding: EdgeInsets.symmetric(vertical: kSmallPaddingValue),
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
            width: 100,
            child: Text(
              leaderboard.userName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Text(
            leaderboard.userPoint.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
