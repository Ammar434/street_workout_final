import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/send_video/send_video_screen.dart';

import '../provider/user_provider.dart';
import '../screens/application/main_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).getUser;
    return const MainScreen();
    // return const StartTrainingScreen();
    // return const ChallengeInProgressScreen(
    //   isChallenger: true,
    // );

    // return const SendVideoScreen();
  }
}
