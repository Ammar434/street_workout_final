import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_start/challenge_start_screen.dart';

import 'components/body_challenge_failed.dart';
import 'components/body_challenge_succeeded.dart';

class ChallengeEndChallengerScreen extends StatelessWidget {
  const ChallengeEndChallengerScreen({Key? key, required this.isChallengeSucceed}) : super(key: key);
  final bool isChallengeSucceed;
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, ChallengeStartScreen.name, (route) => true);
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
        body: isChallengeSucceed ? BodyForChallengeSucceeded(currentUser: currentUser) : BodyChallengeFailed(currentUser: currentUser),
      ),
    );
  }
}