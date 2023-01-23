import 'package:flutter/material.dart';

import '../../../../models/rewards.dart';
import '../../../../utils/colors.dart';
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
            Tab(text: 'Workout'),
          ],
          indicatorColor: primaryColor,
        ),
        Expanded(
          child: TabBarView(
            children: [
              listUrlImage.isEmpty
                  ? const Center(
                      child: Text("No image upload yet"),
                    )
                  : StaggeredGridView(
                      listUrlImage: listUrlImage,
                    ),
              listReward.isEmpty
                  ? const Center(
                      child: Text("No rewards gain yet"),
                    )
                  : RewardGridView(listReward: listReward),
              Container(),
            ],
          ),
        ),
      ],
    );
  }
}
