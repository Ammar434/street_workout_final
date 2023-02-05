import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/send_video/challenge_explaination_screen/challenge_explaination_screen.dart';
import 'package:street_workout_final/services/firestore_methods/rewards_firestore_methods.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import '../../../../../models/custom_user.dart';
import '../../../../../models/rewards.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../select_challenge/components/custom_tile_for_select_challenge.dart';

class SelfRecordSelectChallengeScreen extends StatelessWidget {
  const SelfRecordSelectChallengeScreen({Key? key}) : super(key: key);
  static String name = "SelfRecordSelectChallengeScreen";

  @override
  Widget build(BuildContext context) {
    List<Reward> listRewards = [];
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: buildAppBar(context, "Select challenge"),
        body: FutureBuilder(
          // Only display reward user not have
          future: RewardsFirestoreMethods().getRewardsStrengthSnapshot(),
          builder: (context, AsyncSnapshot<RewardsCategory> rewardsStrenghCategory) {
            if (rewardsStrenghCategory.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(),
              );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChallengeExplanationScreen(
                            reward: listRewards[index],
                          ),
                        ),
                      );
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
