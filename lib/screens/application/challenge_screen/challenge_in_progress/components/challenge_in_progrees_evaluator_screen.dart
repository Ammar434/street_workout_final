import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:provider/provider.dart';

import '../../../../../models/challenge.dart';
import '../../../../../provider/challenge_provider.dart';
import '../../../../../widgets/rounded_button.dart';
import '../../challenge_end/challenge_end_screen_evaluator/challenge_end_screen_evaluator.dart';
import '../../waitting_room/global_waitting_room/components/user_detail_column_widget.dart';
import 'build_rating.dart';
import 'selectable_row_emoji.dart';

class ChallengeInProgressEvaluatorScreen extends StatelessWidget {
  const ChallengeInProgressEvaluatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    Challenge challenge = challengeProvider.getChallenge;

    double repetionRating = 3;
    double executionRating = 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.secondary,
                Colors.transparent,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: kPaddingValue, right: kPaddingValue, top: kPaddingValue * 5),
            child: Column(
              children: [
                UserDetailColumnItem(
                  imageUrl: challenge.evaluatorImageUrl,
                  userName: challenge.evaluatorName,
                  imageRadius: kRadiusValueImageProfile,
                  fontSize: 18.sp,
                  shouldAnimate: false,
                ),
                SizedBox(
                  height: kPaddingValue * 1,
                ),
                BuildRating(
                  challengerName: challenge.challengerName,
                  onTap1: (r) {
                    repetionRating = r;
                  },
                  onTap2: (r) {
                    executionRating = r;
                  },
                ),
                SelectableEmojiRow(challengerName: challenge.challengerName),
                RoundedButton(
                  onTap: () async {
                    await challengeProvider.updateChallengeScore(
                      executionRating: executionRating,
                      repetitionRating: repetionRating,
                    );
                    await challengeProvider.endChallenge(false).then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChallengeEndScreenEvaluator(),
                            ),
                          ),
                        );
                  },
                  text: "End challenge",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
