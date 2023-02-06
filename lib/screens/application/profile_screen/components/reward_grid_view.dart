import 'package:flutter/material.dart';

import '../../../../models/rewards.dart';

class RewardGridView extends StatelessWidget {
  const RewardGridView({
    Key? key,
    required this.listReward,
  }) : super(key: key);

  final List<Reward> listReward;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(
        listReward.length,
        (index) => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Image.network(listReward[index].imageUrl),
            ),
            Text(
              listReward[index].title,
            ),
          ],
        ),
      ),
    );
  }
}
