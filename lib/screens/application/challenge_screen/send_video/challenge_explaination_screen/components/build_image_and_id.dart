import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../../../models/rewards.dart';

class BuildImageAndId extends StatelessWidget {
  const BuildImageAndId({
    super.key,
    required this.reward,
  });

  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(child: Image.asset("assets/images/challenge/asset_1.png")),
          Text(
            "Challenge #${reward.id.substring(reward.id.length - 5)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kDefaultTitleSize,
            ),
          ),
          const Text("If you never try you'll never know"),
        ],
      ),
    );
  }
}
