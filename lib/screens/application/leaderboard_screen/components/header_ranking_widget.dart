import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';

class HeaderRankingWIdget extends StatelessWidget {
  const HeaderRankingWIdget({
    Key? key,
    required this.userName,
    required this.userScore,
    this.gradient,
  }) : super(key: key);

  final String userName;
  final int userScore;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          LottieBuilder.network(
            "https://assets8.lottiefiles.com/private_files/lf30_rjuv1b.json",
            repeat: true,
          ),
          // Image.asset("assets/images/leaderboard/star_explosion.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: kPaddingValue,
              ),
              RoundedCircleUserProfileWidget(
                gradient: gradient,
                radius: kRadiusValue * 6,
              ),
              const SizedBox(
                height: kPaddingValue,
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                userScore.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: kPaddingValue,
              )
            ],
          ),
        ],
      ),
    );
  }
}
