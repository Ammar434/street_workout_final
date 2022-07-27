import 'package:flutter/material.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'challenge_is_not_start_widget.dart';
import 'challenge_is_start_widget.dart';

class BottomPartChallengeScreen extends StatelessWidget {
  const BottomPartChallengeScreen({
    Key? key,
    required this.flag,
    required this.challengerOnTap,
    required this.evaluatorOnTap,
    required this.customUser,
    required this.isEvaluatorFound,
    required this.listChallenge,
  }) : super(key: key);

  final bool isEvaluatorFound;
  final bool flag;
  final GestureTapCallback challengerOnTap;
  final GestureTapCallback evaluatorOnTap;
  final CustomUser customUser;
  final List<Challenge> listChallenge;

  Widget? buildChild() {
    if (customUser.favoriteParc.isEmpty) {
      return const Expanded(
        child: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Center(
            child: Text(
              "You dont have a favorite parc yet, please select one before start challenge",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      if (flag) {
        return ChallengeIsNotStartWidget(
          challengerOnTap: challengerOnTap,
          evaluatorOnTap: evaluatorOnTap,
        );
      } else {
        return ChallengeIsStartWidget(
          customUser: customUser,
          isEvaluatorFound: isEvaluatorFound,
          listChallenge: listChallenge,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: buildChild(),
      ),
    );
  }
}
