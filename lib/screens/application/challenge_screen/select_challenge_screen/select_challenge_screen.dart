import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/select_challenge_screen/components/custom_tile_for_select_challenge.dart';
import 'package:street_workout_final/services/firestore_methods/rewards_firestore_methods.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

class SelectChallengeScreen extends StatelessWidget {
  SelectChallengeScreen({Key? key, required this.evaluatorId}) : super(key: key);
  final String evaluatorId;
  static String name = "SelectChallengeScreen";
  @override
  Widget build(BuildContext context) {
    List<Reward> listRewards = [];
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    // Challenge challenge = Provider.of<ChallengeProvider>(context).getChallenge;

    // debugPrint(challenge.evaluatorUid);

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, "Select a challenge"),
        body: FutureBuilder(
          future: RewardsFirestoreMethods().getRewardsStrengthSnapshot(),
          builder: (context, AsyncSnapshot<RewardsCategory> rewardsStrenghCategory) {
            if (rewardsStrenghCategory.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingWidget());
            }
            for (Reward rewards in rewardsStrenghCategory.data!.rewardsList) {
              if (!currentUser.rewards.contains(rewards.id)) {
                listRewards.add(rewards);
              }
            }

            return Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: ListView.builder(
                itemCount: listRewards.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomTileForSelectChallenge(
                    rewards: listRewards[index],
                    onTap: () async {
                      //Write to rtmdb
                      await challengeProvider.writeChallengeIdToRealtimeDatabase(
                        currentUserAsChallenger: currentUser,
                        evaluatorReference: evaluatorId,
                        challengeId: listRewards[index].id,
                      );
                      //Navigate to global waiting room
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
