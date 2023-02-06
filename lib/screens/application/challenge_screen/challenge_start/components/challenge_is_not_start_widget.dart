import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../../widgets/rounded_button.dart';
import '../../send_video/send_video_screen.dart';

class ChallengeIsNotStartWidget extends StatelessWidget {
  const ChallengeIsNotStartWidget({
    Key? key,
    required this.challengerOnTap,
    required this.evaluatorOnTap,
  }) : super(key: key);

  final GestureTapCallback challengerOnTap;
  final GestureTapCallback evaluatorOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('1'),
      // color: Colors.red,
      child: Column(
        children: [
          const Text(
            "Welcome to the Challenge",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Text(
            "Here you can unlock new levels, improve your score and challenge others.",
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
            child: Column(
              children: [
                RoundedButton(
                  onTap: challengerOnTap,
                  text: "Get assessed",
                ),
                SizedBox(
                  height: kSmallPaddingValue,
                ),
                RoundedButton(
                  onTap: evaluatorOnTap,
                  text: "Rate someone",
                ),
                SizedBox(
                  height: kSmallPaddingValue,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendVideoScreen(),
                ),
              );
            },
            child: const Text(
              "What if no appraiser is available?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
