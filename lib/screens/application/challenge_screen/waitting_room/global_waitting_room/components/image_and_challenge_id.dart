import 'package:flutter/material.dart';

import '../../../../../../models/challenge.dart';
import '../../../../../../utils/constants.dart';

class ImageAndChallengeId extends StatelessWidget {
  const ImageAndChallengeId({
    super.key,
    required this.challenge,
  });

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(child: Image.asset("assets/images/challenge/asset_1.png")),
          Text(
            "Challenge #${challenge.challengeId.substring(challenge.challengeId.length - 5)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kDefaultTitleSize,
            ),
          ),
          const Text("We will develod this screen soon"),
        ],
      ),
    );
  }
}