import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../models/custom_user.dart';
import '../../../../../provider/user_provider.dart';
import '../../challenge_start/challenge_start_screen.dart';
import 'components/body_challenge_failed.dart';
import 'components/body_challenge_succeeded.dart';

class ChallengeEndChallengerScreen extends StatelessWidget {
  const ChallengeEndChallengerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    const bool isChallengeSucceed = true;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ChallengeStartScreen.name,
                (route) => true,
              );
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
