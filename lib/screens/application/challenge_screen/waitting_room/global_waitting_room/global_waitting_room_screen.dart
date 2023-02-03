import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_in_progress/challenge_in_progress_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_start/challenge_start_screen.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/rounded_button.dart';
import 'components/challenge_and_evaluator_row.dart';
import 'components/challenge_description.dart';
import 'components/image_and_challenge_id.dart';

class GlobalWaittingRoomScreen extends StatelessWidget {
  const GlobalWaittingRoomScreen({Key? key, required this.isChallenger}) : super(key: key);
  static String name = "GlobalWaittingRoomScreen";
  final bool isChallenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ChallengeStartScreen.name,
                (route) => false,
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: kDefaultIconAppBarSize,
            ),
          ),
        ),
        title: const Text("Lobby"),
      ),
      body: Consumer<ChallengeProvider>(
        builder: (context, model, child) {
          bool shouldAnimate() {
            if (isChallenger) {
              return model.getChallenge.isChallengerReady;
            }
            return model.getChallenge.isEvaluatorReady;
          }

          bool isAnimated = shouldAnimate();
          if (model.getChallenge.isChallengerReady && model.getChallenge.isEvaluatorReady) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengeInProgressScreen(
                  isChallenger: isChallenger,
                ),
              ),
            );
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor,
                  Colors.transparent,
                  backgroundColor,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: Column(
                children: [
                  SizedBox(
                    height: kPaddingValue * 3,
                  ),
                  ImageAndChallengeId(
                    challenge: model.getChallenge,
                  ),
                  SizedBox(
                    height: kPaddingValue * 3,
                  ),
                  ChallengerAndEvaluatorRow(
                    challenge: model.getChallenge,
                    shouldAnimateChallenger: model.getChallenge.isChallengerReady,
                    shouldAnimateEvaluator: model.getChallenge.isEvaluatorReady,
                  ),
                  const ChallengeDescription(),
                  RoundedButton(
                    onTap: () async {
                      await model.getReadyForTheChallenge(
                        isChallenger,
                        isAnimated,
                      );
                    },
                    text: isAnimated ? "Ready" : "Not ready yet",
                    shouldAnimate: isAnimated,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
