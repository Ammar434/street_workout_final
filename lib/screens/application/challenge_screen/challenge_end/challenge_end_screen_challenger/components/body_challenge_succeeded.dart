import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/utils/constants.dart';

class BodyForChallengeSucceeded extends StatelessWidget {
  const BodyForChallengeSucceeded({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final CustomUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.network(
          "https://assets6.lottiefiles.com/packages/lf20_jbrw3hcz.json",
          repeat: false,
        ),
        const SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Congrats ${currentUser.userName}!",
          style: const TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "You're succedeed the challenge !",
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "That's your ${currentUser.rewards.length} challenge. Keep going you're a beast",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: kDefaultTitleSize * 0.6,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
