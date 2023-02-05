import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../models/rewards.dart';
import '../../../../../../utils/constants.dart';

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
            reward.descriptionForChallenger.length,
            (index) => ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidCircle),
              title: Text(reward.descriptionForChallenger[index]),
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
