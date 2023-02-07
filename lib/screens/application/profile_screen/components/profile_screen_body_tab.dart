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
    return Column(
      children: [
        const TabBar(
          tabs: [
            Tab(text: 'Photos'),
            Tab(text: 'Rewards'),
            // Tab(text: 'Workout'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              listUrlImage.isEmpty
                  ? Center(
                      child: Text(
                        "No image upload yet",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  : StaggeredGridView(
                      listUrlImage: listUrlImage,
                    ),
              listReward.isEmpty
                  ? Center(
                      child: Text(
                        "No rewards gain yet",
                        style: Theme.of(context).textTheme.titleSmall,
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
