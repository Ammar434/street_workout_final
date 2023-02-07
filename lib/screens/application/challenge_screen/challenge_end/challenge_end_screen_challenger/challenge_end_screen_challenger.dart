import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/common_libs.dart';
import '../../../../../provider/challenge_provider.dart';
import 'components/body_challenge_failed.dart';
import 'components/body_challenge_succeeded.dart';
import '../../../../../widgets/loading_widget.dart';

class ChallengeEndChallengerScreen extends StatelessWidget {
  const ChallengeEndChallengerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingWidget(),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  const Text("Waitting for evaluator to finish evaluation"),
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
