import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/custom_user.dart';
import '../../../../models/rewards.dart';
import '../../../../provider/challenge_provider.dart';
import '../../../../provider/user_provider.dart';
import 'components/custom_tile_for_select_challenge.dart';
import '../../../../services/firestore_methods/rewards_firestore_methods.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/loading_widget.dart';

class SelectChallengeScreen extends StatelessWidget {
  const SelectChallengeScreen({Key? key, required this.evaluatorId}) : super(key: key);
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
              return const Center(child: LoadingWidget());
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
