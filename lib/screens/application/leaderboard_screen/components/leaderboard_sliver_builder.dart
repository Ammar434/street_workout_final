import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/leaderboard.dart';
import 'package:street_workout_final/screens/application/leaderboard_screen/components/tile_leaderboard_row.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/gradients.dart';
import '../../../../widgets/loading_widget.dart';
import 'header_ranking_widget.dart';

class LeaderboardSliverBuilder extends StatelessWidget {
  const LeaderboardSliverBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").orderBy("rank", descending: false).limit(100).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return const SizedBox(
            height: 200,
            width: double.infinity,
            child: LoadingWidget(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                "Some internal error happen",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }
        print("size${snapshot.data!.size}");
        Leaderboard topAthlete = Leaderboard.leaderboardFromSnapshot(snapshot.data!.docs[0]);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
          child: CustomScrollView(
            slivers: [
              HeaderRankingWIdget(
                leaderboard: topAthlete,
                gradient: goldGradient,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: snapshot.data!.size - 1,
                  ((context, index2) {
                    if (index2 == 0) {
                      return TileLeaderboardRow(
                        index: index2 + 2,
                        gradient: silverGradient,
                        leaderboard: Leaderboard.leaderboardFromSnapshot(snapshot.data!.docs[index2 + 1]),
                      );
                    }
                    if (index2 == 1) {
                      return TileLeaderboardRow(
                        index: index2 + 2,
                        gradient: bronzeGradient,
                        leaderboard: Leaderboard.leaderboardFromSnapshot(snapshot.data!.docs[index2 + 1]),
                      );
                    }
                    return TileLeaderboardRow(
                      index: index2 + 2,
                      leaderboard: Leaderboard.leaderboardFromSnapshot(snapshot.data!.docs[index2 + 1]),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
