import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../models/custom_user.dart';
import '../../../../../provider/user_provider.dart';

class ChallengeEndScreenEvaluator extends StatelessWidget {
  const ChallengeEndScreenEvaluator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Center(
              child: FaIcon(FontAwesomeIcons.xmark),
            ),
          ),
          actions: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: FaIcon(FontAwesomeIcons.shareNodes),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
              "https://assets8.lottiefiles.com/private_files/lf30_v1khlfsu.json",
              repeat: true,
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            Text(
              "You're the best ${currentUser.userName}!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Always remmenber",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            Text(
              "You just raised yourself by lifting others.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
