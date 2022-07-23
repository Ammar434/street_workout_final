import 'package:flutter/material.dart';
import 'tile_leaderboard_row.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/gradients.dart';

import 'header_ranking_widget.dart';

class LeaderboardSliverBuilder extends StatelessWidget {
  const LeaderboardSliverBuilder({
    Key? key,
    required this.userName,
    required this.userScore,
  }) : super(key: key);

  final String userName;
  final int userScore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: CustomScrollView(
        // mainAxisSize: MainAxisSize.max,
        slivers: [
          HeaderRankingWIdget(
            userName: userName,
            userScore: userScore,
            gradient: goldGradient,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                if (index == 0) {
                  return TileLeaderboardRow(
                    userScore: userScore,
                    index: index + 2,
                    gradient: silverGradient,
                  );
                }
                if (index == 1) {
                  return TileLeaderboardRow(
                    userScore: userScore,
                    index: index + 2,
                    gradient: bronzeGradient,
                  );
                }
                return TileLeaderboardRow(
                  userScore: userScore,
                  index: index + 2,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
