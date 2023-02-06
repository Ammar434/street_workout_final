import 'package:flutter/material.dart';

import '../../../../models/rewards.dart';
import '../../../../widgets/staggered_grid_view.dart';
import 'reward_grid_view.dart';

class ProfileScreenBodyTab extends StatelessWidget {
  const ProfileScreenBodyTab({
    Key? key,
    required this.listUrlImage,
    required this.listReward,
  }) : super(key: key);

  final List<String> listUrlImage;
  final List<Reward> listReward;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        TabBar(
          tabs: const [
            Tab(text: 'Photos'),
            Tab(text: 'Rewards'),
            // Tab(text: 'Workout'),
          ],
          indicatorColor: Theme.of(context).colorScheme.secondary,
        ),
        Expanded(
          child: TabBarView(
            children: [
              listUrlImage.isEmpty
                  ? Center(
                      child: Text(
                        "No image upload yet",
                        style: textStyle,
                      ),
                    )
                  : StaggeredGridView(
                      listUrlImage: listUrlImage,
                    ),
              listReward.isEmpty
                  ? Center(
                      child: Text(
                        "No rewards gain yet",
                        style: textStyle,
                      ),
                    )
                  : RewardGridView(listReward: listReward),
              // Container(),
            ],
          ),
        ),
      ],
    );
  }
}
