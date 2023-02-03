import 'package:flutter/material.dart';

import 'components/challenge_in_progrees_challenger_screen.dart';
import 'components/challenge_in_progrees_evaluator_screen.dart';

class ChallengeInProgressScreen extends StatelessWidget {
  const ChallengeInProgressScreen({Key? key, required this.isChallenger}) : super(key: key);
  final bool isChallenger;
  @override
  Widget build(BuildContext context) {
    return isChallenger ? const ChallengeInProgressChallengerScreen() : const ChallengeInProgressEvaluatorScreen();
  }
}
