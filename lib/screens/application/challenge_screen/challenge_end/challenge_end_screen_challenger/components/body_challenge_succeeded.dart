import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/user_provider.dart';

class BodyForChallengeSucceeded extends StatelessWidget {
  const BodyForChallengeSucceeded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.network(
          "https://assets6.lottiefiles.com/packages/lf20_jbrw3hcz.json",
          repeat: false,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Congrats ${currentUser.userName}!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "You're succedeed the challenge !",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "That's your ${currentUser.rewards.length + 1} challenge. Keep going you're a beast",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
