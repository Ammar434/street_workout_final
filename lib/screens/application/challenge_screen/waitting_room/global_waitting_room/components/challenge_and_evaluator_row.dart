import 'package:flutter/material.dart';

import '../../../../../../models/challenge.dart';
import '../../../../../../utils/constants.dart';
import 'user_detail_column_widget.dart';

class ChallengerAndEvaluatorRow extends StatelessWidget {
  const ChallengerAndEvaluatorRow({
    super.key,
    required this.challenge,
    required this.shouldAnimateEvaluator,
    required this.shouldAnimateChallenger,
  });

  final Challenge challenge;
  final bool shouldAnimateEvaluator;
  final bool shouldAnimateChallenger;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPaddingValue * 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserDetailColumnItem(
              imageUrl: challenge.challengerImageUrl,
              userName: challenge.challengerName,
              shouldAnimate: shouldAnimateChallenger,
            ),
            UserDetailColumnItem(
              imageUrl: challenge.evaluatorImageUrl,
              userName: challenge.evaluatorName,
              shouldAnimate: shouldAnimateEvaluator,
            ),
          ],
        ),
      ),
    );
  }
}
