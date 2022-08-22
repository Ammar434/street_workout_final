import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../models/custom_user.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../utils/constants.dart';

import '../../challenge_start/challenge_start_screen.dart';

class ChallengeEndScreenEvaluator extends StatelessWidget {
  ChallengeEndScreenEvaluator({Key? key}) : super(key: key);

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
            child: Center(
              child: FaIcon(FontAwesomeIcons.xmark),
            ),
          ),
          actions: [
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
              "https://assets9.lottiefiles.com/packages/lf20_36zspn0e.json",
              repeat: true,
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            Text(
              "You're the best ${currentUser.userName}!",
              style: TextStyle(
                fontSize: kDefaultTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Always remmenber",
              style: TextStyle(
                fontSize: kDefaultTitleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            Text(
              "You just raised yourself by lifting others.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kDefaultTitleSize * 0.6,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
