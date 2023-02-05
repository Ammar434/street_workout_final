import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:street_workout_final/screens/application/challenge_screen/send_video/self_record_select_challenge_screen/self_record_select_challenge_screen.dart';
import 'package:street_workout_final/widgets/app_bar.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_button.dart';

class SendVideoScreen extends StatelessWidget {
  const SendVideoScreen({Key? key}) : super(key: key);
  // TODO : Filme video live , directement en 360? => Avantage moins de forfait gaspillé
  //        Upload video sur cloud
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
            const Text(
              "No one to evaluate you?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              "Don't worry you can record yourself we will evaluate your performance as soon as possible",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
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
