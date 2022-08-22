import 'package:flutter/material.dart';

import '../../../../models/leaderboard.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';

class TileLeaderboardRow extends StatelessWidget {
  TileLeaderboardRow({
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
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          Text(
            leaderboard.userPoint.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
