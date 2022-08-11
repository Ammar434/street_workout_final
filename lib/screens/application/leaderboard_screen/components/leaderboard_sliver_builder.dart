import 'package:flutter/material.dart';
import 'package:street_workout_final/models/leaderboard.dart';
import 'package:street_workout_final/screens/application/leaderboard_screen/components/tile_leaderboard_row.dart';
import 'package:street_workout_final/services/firestore_methods/leaderboard_firestore_methods.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/gradients.dart';

import 'header_ranking_widget.dart';

class LeaderboardSliverBuilder extends StatelessWidget {
  const LeaderboardSliverBuilder({
    Key? key,
    required this.categorie,
  }) : super(key: key);

  final String categorie;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Leaderboard>>(
      future: LeaderboardFirestoreMethods().leaderboardList(categorie),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasData) {
          debugPrint("hello");

          List<Leaderboard> leaderboardList = snapshot.data!;

          debugPrint("hello${leaderboardList.length}");

          if (leaderboardList.isEmpty) {
            return const Center(child: Text("Some internal error happen"));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
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

            // CustomScrollView(
            //   slivers: List.generate(
            //     leaderboardList.length,
            //     (index) {
            //       if (index == 0) {
            //         return HeaderRankingWIdget(
            //           leaderboard: leaderboardList[index],
            //           gradient: goldGradient,
            //         );
            //       }
            //       return SliverList(
            //         delegate: SliverChildBuilderDelegate(
            //           childCount: leaderboardList.length - 1,
            //           ((context, index2) {
            //             if (index2 == 0) {
            //               return TileLeaderboardRow(
            //                 index: index2 + 2,
            //                 gradient: silverGradient,
            //                 leaderboard: leaderboardList[index],
            //               );
            //             }
            //             if (index2 == 1) {
            //               return TileLeaderboardRow(
            //                 index: index2 + 2,
            //                 gradient: bronzeGradient,
            //                 leaderboard: leaderboardList[index],
            //               );
            //             }
            //             return TileLeaderboardRow(
            //               index: index2 + 2,
            //               leaderboard: leaderboardList[index],
            //             );
            //           }),
            //         ),
            //       );
            //     },
            //   ),
            // ),
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
