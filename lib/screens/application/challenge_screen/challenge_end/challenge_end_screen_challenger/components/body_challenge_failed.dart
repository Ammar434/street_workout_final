import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/utils/constants.dart';

class BodyChallengeFailed extends StatelessWidget {
  BodyChallengeFailed({
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
          "https://assets2.lottiefiles.com/packages/lf20_ed9D2z.json",
          repeat: false,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Ahh so close ${currentUser.userName}!",
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Always remmenber",
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "In life, there is no such thing as impossible; it’s always possible. ~",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kDefaultTitleSize * 0.6,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
