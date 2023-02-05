import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_end/challenge_end_screen_evaluator/challenge_end_screen_evaluator.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_in_progress/components/selectable_row_emoji.dart';
import 'package:street_workout_final/utils/colors.dart';

import '../../../../../models/challenge.dart';
import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/rounded_button.dart';
import '../../waitting_room/global_waitting_room/components/user_detail_column_widget.dart';
import 'build_rating.dart';

class ChallengeInProgressEvaluatorScreen extends StatelessWidget {
  const ChallengeInProgressEvaluatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    Challenge challenge = challengeProvider.getChallenge;

    double repetionRating = 0;
    double executionRating = 0;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              backgroundColor,
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
    );
  }
}
