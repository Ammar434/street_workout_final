import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../models/rewards.dart';

class BuildInstruction extends StatelessWidget {
  const BuildInstruction({
    super.key,
    required this.reward,
  });

  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kPaddingValue * 5,
          ),
          const Text(
            'What you have to do:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          ...List.generate(
            reward.description.length,
            (index) => ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidCircle),
              title: Text(reward.description[index]),
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
        ],
      ),
    );
  }
}
