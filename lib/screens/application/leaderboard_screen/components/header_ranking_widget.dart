import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';

import '../../../../models/leaderboard.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';

class HeaderRankingWIdget extends StatelessWidget {
  const HeaderRankingWIdget({
    Key? key,
    this.gradient,
    required this.leaderboard,
  }) : super(key: key);

  final Leaderboard leaderboard;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          LottieBuilder.network(
            "https://assets1.lottiefiles.com/private_files/lf30_i5wfnbcg.json",
            repeat: true,
          ),
          // Image.asset("assets/images/leaderboard/star_explosion.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: kPaddingValue,
              ),
              RoundedCircleUserProfileWidget(
                gradient: gradient,
                radius: kRadiusValue * 6,
                imageUrl: leaderboard.userProfileImage,
              ),
              SizedBox(
                height: kPaddingValue,
              ),
              Text(
                leaderboard.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                leaderboard.userPoint.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: kPaddingValue,
              )
            ],
          ),
        ],
      ),
    );
  }
}
