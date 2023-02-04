import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';

import '../../../../models/challenge.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/user_provider.dart';
import 'components/challenge_in_progrees_challenger_screen.dart';
import 'components/challenge_in_progrees_evaluator_screen.dart';

class ChallengeInProgressScreen extends StatelessWidget {
  const ChallengeInProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;
    Challenge challenge = Provider.of<ChallengeProvider>(context).getChallenge;

    if (challenge.challengerUid == customUser.uid) {
      return const ChallengeInProgressChallengerScreen();
    }
    return const ChallengeInProgressEvaluatorScreen();
  }
}
