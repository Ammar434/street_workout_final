import 'package:flutter/material.dart';

import "../../../../../../common_libs.dart";
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
          Text(
            'What you have to do:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          ...List.generate(
            reward.description.length,
            (index) => ListTile(
              leading: const Icon(Icons.circle_rounded),
              title: Text(
                reward.description[index],
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
