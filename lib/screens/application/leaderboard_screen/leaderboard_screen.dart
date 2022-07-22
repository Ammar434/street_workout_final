import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'components/leaderboard_sliver_builder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;
    String userName = "Ammar434";
    int userScore = 234000;
    if (customUser.favoriteParc == "") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "To access this part of the application, please enter the park where you trained.",
            textAlign: TextAlign.center,
          ),
          Text(
            "Enter your park",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
          )
        ],
      );
    }
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
