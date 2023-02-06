import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../challenge_end/challenge_end_screen_challenger/challenge_end_screen_challenger.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/rounded_button.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/colors.dart';

class ChallengeInProgressChallengerScreen extends StatelessWidget {
  const ChallengeInProgressChallengerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<ChallengeProvider>(
        builder: (context, model, child) {
          if (model.getChallenge.isChallengeEndChallenger) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChallengeEndChallengerScreen(),
                  ),
                );
              },
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
                  Colors.transparent,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Lottie.asset(
                      "assets/lotties/pull_up.json",
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
                    onTap: () async {
                      await model.endChallenge(true).then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChallengeEndChallengerScreen(),
                              ),
                            ),
                          );

                      // await model.endChallenge(true);
                    },
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
