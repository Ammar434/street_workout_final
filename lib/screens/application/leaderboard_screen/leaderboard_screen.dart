import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'components/leaderboard_sliver_builder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = "Ammar434";
    int userScore = 234000;

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            indicatorColor: primaryColor,
            indicator: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(
                kRadiusValue,
              ),
            ),
            labelColor: Colors.white,
            // unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(text: "Day"),
              Tab(text: 'Week'),
              Tab(text: 'Month'),
              Tab(text: 'Year'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                LeaderboardSliverBuilder(
                  userName: userName,
                  userScore: userScore,
                ),
                LeaderboardSliverBuilder(
                  userName: userName,
                  userScore: userScore,
                ),
                LeaderboardSliverBuilder(
                  userName: userName,
                  userScore: userScore,
                ),
                LeaderboardSliverBuilder(
                  userName: userName,
                  userScore: userScore,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
