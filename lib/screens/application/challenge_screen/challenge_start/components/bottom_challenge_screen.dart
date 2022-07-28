import 'package:flutter/material.dart';

import 'challenge_is_not_start_widget.dart';
import 'challenge_is_start_widget.dart';

class BottomPartChallengeScreen extends StatelessWidget {
  const BottomPartChallengeScreen({
    Key? key,
    required this.widgetToDisplay,
    required this.challengerOnTap,
    required this.evaluatorOnTap,
  }) : super(key: key);

  final bool widgetToDisplay;
  final GestureTapCallback challengerOnTap;
  final GestureTapCallback evaluatorOnTap;

  Widget? buildChild() {
    if (widgetToDisplay) {
      return ChallengeIsNotStartWidget(
        challengerOnTap: challengerOnTap,
        evaluatorOnTap: evaluatorOnTap,
      );
    } else {
      return const ChallengeIsStartWidget();
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
