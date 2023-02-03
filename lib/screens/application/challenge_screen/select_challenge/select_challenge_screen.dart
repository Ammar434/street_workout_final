import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/services/firestore_methods/rewards_firestore_methods.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import '../../../../models/custom_user.dart';
import '../../../../models/rewards.dart';
import '../../../../provider/challenge_provider.dart';
import '../../../../provider/user_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/snackbar.dart';
import '../waitting_room/challenger_waitting_room/challenger_waitting_room_screen.dart';
import 'components/custom_tile_for_select_challenge.dart';

class SelectChallengeScreen extends StatefulWidget {
  const SelectChallengeScreen({
    Key? key,
  }) : super(key: key);
  static String name = "SelectChallengeScreen";

  @override
  State<SelectChallengeScreen> createState() => _SelectChallengeScreenState();
}

class _SelectChallengeScreenState extends State<SelectChallengeScreen> {
  late ChallengeProvider challengeProvider;
  @override
  void initState() {
    super.initState();
    challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
  }

  @override
  void deactivate() {
    super.deactivate();
    challengeProvider.deleteRoom(true);
  }

  @override
  Widget build(BuildContext context) {
    List<Reward> listRewards = [];
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
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
                      //Write to rtmdb
                      // Navigator.of(context).pushNamed(ChallengerWaittinRoomScreen.name);

                      String res = await challengeProvider.updateChallengeId(
                        listRewards[index].id,
                      );
                      if (res == "Success") {
                        Navigator.of(context).pushNamed(ChallengerWaittinRoomScreen.name);
                      } else {
                        customShowSnackBar(
                          globalKey: scaffoldKey,
                          title: "Error",
                          content: res,
                          contentType: ContentType.failure,
                        );
                      }
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
