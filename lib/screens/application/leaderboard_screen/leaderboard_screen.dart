import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/favorite_parc/favorite_parc_empty_screen.dart';

import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'components/leaderboard_sliver_builder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser!;

    if (customUser.favoriteParc.isEmpty) {
      return const FavoriteParcEmptyScreen(
        displayButton: false,
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
          const Expanded(
            child: TabBarView(
              children: [
                LeaderboardSliverBuilder(
                  categorie: "day",
                ),
                LeaderboardSliverBuilder(
                  categorie: "week",
                ),
                LeaderboardSliverBuilder(
                  categorie: "month",
                ),
                LeaderboardSliverBuilder(
                  categorie: "year",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
