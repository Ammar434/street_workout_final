import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_end/challenge_end_screen_challenger/challenge_end_screen_challenger.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/colors.dart';

class ChallengeInProgressChallengerScreen extends StatelessWidget {
  const ChallengeInProgressChallengerScreen({
    Key? key,
  }) : super(key: key);

  void endChallenge() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<ChallengeProvider>(
        builder: (context, model, child) {
          if (model.getChallenge.isChallengeEnd) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChallengeEndChallengerScreen(
                  isChallengeSucceed: true,
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
                  backgroundColor,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/challenge/asset_6.png",
                    ),
                  ),
                  Text(
                    'You re being evaluated now, do your best champion but always remmenber there is no honor and no progress in cheating. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kPaddingValue * 5,
                  ),
                  RoundedButton(
                    onTap: () {},
                    text: "End challenge",
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
