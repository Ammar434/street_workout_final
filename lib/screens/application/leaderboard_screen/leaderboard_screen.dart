import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../../../common_libs.dart";
import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/firestore_methods/leaderboard_firestore_methods.dart';
import '../../../widgets/loading_widget.dart';
import '../favorite_parc/favorite_parc_empty_screen.dart';
import 'components/countdown.dart';
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

    return FutureBuilder<Duration>(
      future: LeaderboardFirestoreMethods().timeLeft(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Column(
              children: [
                Text(
                  "Leaderboard",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: kPaddingValue * 2,
                ),
                Countdown(
                  duration: snapshot.data,
                ),
                const Expanded(
                  child: LeaderboardSliverBuilder(),
                ),
              ],
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
