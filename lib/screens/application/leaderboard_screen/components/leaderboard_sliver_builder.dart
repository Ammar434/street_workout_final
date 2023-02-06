import 'package:flutter/material.dart';

import '../../../../models/leaderboard.dart';
import '../../../../services/firestore_methods/leaderboard_firestore_methods.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/gradients.dart';
import '../../../../widgets/loading_widget.dart';
import 'header_ranking_widget.dart';
import 'tile_leaderboard_row.dart';

class LeaderboardSliverBuilder extends StatelessWidget {
  const LeaderboardSliverBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Leaderboard>>(
      future: LeaderboardFirestoreMethods().leaderboardList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Leaderboard> leaderboardList = snapshot.data!;

          if (leaderboardList.isEmpty) {
            return const Center(child: Text("Some internal error happen"));
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
            child: CustomScrollView(
              slivers: [
                HeaderRankingWIdget(
                  leaderboard: leaderboardList[0],
                  gradient: goldGradient,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: leaderboardList.length - 1,
                    ((context, index2) {
                      if (index2 == 0) {
                        return TileLeaderboardRow(
                          index: index2 + 2,
                          gradient: silverGradient,
                          leaderboard: leaderboardList[index2 + 1],
                        );
                      }
                      if (index2 == 1) {
                        return TileLeaderboardRow(
                          index: index2 + 2,
                          gradient: bronzeGradient,
                          leaderboard: leaderboardList[index2 + 1],
                        );
                      }
                      return TileLeaderboardRow(
                        index: index2 + 2,
                        leaderboard: leaderboardList[index2 + 1],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }
        // }

        return const Center(
          child: LoadingWidget(),
        );
      },
    );
  }
}
