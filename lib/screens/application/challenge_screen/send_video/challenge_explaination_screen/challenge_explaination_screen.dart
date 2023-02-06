import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../models/rewards.dart';
import '../../../../../widgets/rounded_button.dart';
import '../record_video_screen/record_video_screen.dart';
import 'components/build_image_and_id.dart';
import 'components/build_instructions.dart';

class ChallengeExplanationScreen extends StatelessWidget {
  const ChallengeExplanationScreen({Key? key, required this.reward}) : super(key: key);
  final Reward reward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: kDefaultIconAppBarSize,
            ),
          ),
        ),
        title: const Text("Lobby"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Colors.transparent,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(kPaddingValue),
            child: Column(
              children: [
                BuildImageAndId(reward: reward),
                BuildInstruction(reward: reward),
                RoundedButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordVideoScreen(
                          challengeId: reward.id,
                        ),
                      ),
                    );
                  },
                  text: "Start recording",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
