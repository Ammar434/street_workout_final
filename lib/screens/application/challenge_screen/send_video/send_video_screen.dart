import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import "../../../../common_libs.dart";
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/rounded_button.dart';
import 'self_record_select_challenge_screen/self_record_select_challenge_screen.dart';

class SendVideoScreen extends StatelessWidget {
  const SendVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                "assets/lotties/empty.json",
              ),
            ),
            Text(
              "No one to evaluate you?",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Don't worry you can record yourself we will evaluate your performance as soon as possible",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: kPaddingValue * 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
              child: RoundedButton(
                onTap: () {
                  Navigator.pushNamed(context, SelfRecordSelectChallengeScreen.name);
                },
                text: "Start challenge",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
