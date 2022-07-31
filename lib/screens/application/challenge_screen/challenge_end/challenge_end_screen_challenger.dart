import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_start/challenge_start_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

class ChallengeEndChallengerScreen extends StatelessWidget {
  const ChallengeEndChallengerScreen({Key? key, required this.isChallengeSucceed}) : super(key: key);
  final bool isChallengeSucceed;
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, ChallengeStartScreen.name, (route) => true);
            },
            child: const Center(
              child: FaIcon(FontAwesomeIcons.xmark),
            ),
          ),
          actions: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: FaIcon(FontAwesomeIcons.shareNodes),
              ),
            )
          ],
        ),
        body: isChallengeSucceed ? BodyForChallengeSucceeded(currentUser: currentUser) : BodyChallengeFailed(currentUser: currentUser),
      ),
    );
  }
}

class BodyChallengeFailed extends StatelessWidget {
  const BodyChallengeFailed({
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
        const SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Ahh so close ${currentUser.userName}!",
          style: const TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Always remmenber",
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: kPaddingValue,
        ),
        const Text(
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
