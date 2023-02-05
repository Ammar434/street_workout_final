import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_end/challenge_end_screen_challenger/components/body_challenge_failed.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_end/challenge_end_screen_challenger/components/body_challenge_succeeded.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import '../../challenge_start/challenge_start_screen.dart';

class ChallengeEndChallengerScreen extends StatelessWidget {
  const ChallengeEndChallengerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ChallengeStartScreen.name,
                (route) => true,
              );
            },
            child: const Center(
              child: FaIcon(FontAwesomeIcons.xmark),
            ),
          ),
        ),
        body: Consumer<ChallengeProvider>(
          builder: (context, model, child) {
            if (model.getChallenge.isChallengeEndEvaluator == false) {
              return Column(
                children: const [
                  LoadingWidget(),
                  Text("Waitting for evaluator to finish evaluation"),
                ],
              );
            }

            double challengeScore = (model.getChallenge.executionRating + model.getChallenge.repetitionRating) / 2;
            if (challengeScore >= 3) {
              return const BodyForChallengeSucceeded();
            } else {
              return const BodyChallengeFailed();
            }
          },
        ),
        // body: isChallengeSucceed ? BodyForChallengeSucceeded(currentUser: currentUser) : BodyChallengeFailed(currentUser: currentUser),
      ),
    );
  }
}
