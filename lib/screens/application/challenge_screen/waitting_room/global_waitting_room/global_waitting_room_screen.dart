import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../widgets/rounded_button.dart';
import '../../challenge_in_progress/challenge_in_progress_screen.dart';
import 'components/challenge_and_evaluator_row.dart';
import 'components/challenge_description.dart';
import 'components/image_and_challenge_id.dart';

class GlobalWaittingRoomScreen extends StatelessWidget {
  const GlobalWaittingRoomScreen({Key? key, required this.isChallenger}) : super(key: key);
  static String name = "GlobalWaittingRoomScreen";
  final bool isChallenger;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeProvider>(
      builder: (context, model, child) {
        bool shouldAnimate() {
          if (isChallenger) {
            return model.getChallenge.isChallengerReady;
          }
          return model.getChallenge.isEvaluatorReady;
        }

        bool isAnimated = shouldAnimate();
        if (model.getChallenge.isChallengerReady && model.getChallenge.isEvaluatorReady) {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChallengeInProgressScreen(),
                ),
              );
            },
          );

          // return  ChallengeInProgressScreen();
        }
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                ),
              ),
              title: Text(
                "Lobby",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.tertiaryContainer,
                    Colors.transparent,
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
                    ChallengeDescription(
                      isChallenger: isChallenger,
                      rewardId: model.getChallenge.challengeId,
                    ),
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
            ));
      },
    );
  }
}
