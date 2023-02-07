import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

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
            icon: const Icon(
              Icons.chevron_left,
            ),
          ),
        ),
        title: Text(
          "Lobby",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.tertiaryContainer,
                Colors.transparent,
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
