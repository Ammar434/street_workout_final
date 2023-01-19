import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/challenge.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/challenge_provider.dart';
import '../../../../provider/user_provider.dart';
import '../challenge_in_progress/challenge_in_progress_screen.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_button.dart';

import '../components/user_detail_column_widget.dart';

class GlobalWaittingRoomScreen extends StatefulWidget {
  const GlobalWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "GlobalWaittingRoomScreen";

  @override
  State<GlobalWaittingRoomScreen> createState() => _GlobalWaittingRoomScreenState();
}

class _GlobalWaittingRoomScreenState extends State<GlobalWaittingRoomScreen> {
  bool isLoading = true;

  bool buttonAnimation = false;
  void loadData() async {
    await Provider.of<ChallengeProvider>(context, listen: false).listenToChallenge();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    Challenge challenge = challengeProvider.getChallenge;
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    if (challenge.isEvaluatorReady && challenge.isChallengerReady) {
      return ChallengeInProgressScreen(
        challenge: challenge,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: kDefaultIconAppBarSize,
            ),
          ),
        ),
        title: const Text("Lobby"),
      ),
      body: isLoading
          ? const LoadingWidget()
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    backgroundColor,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    primaryColor,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(kPaddingValue),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.asset("assets/images/challenge/asset_1.png"),
                    ),
                    Text(
                      "Challenge #423424",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultTitleSize,
                      ),
                    ),
                    const Text("We will develod this screen soon"),
                    SizedBox(
                      height: kPaddingValue * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPaddingValue * 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserDetailColumnItem(
                            imageUrl: challenge.challengerImageUrl,
                            userName: challenge.challengerName,
                          ),
                          UserDetailColumnItem(
                            imageUrl: challenge.evaluatorImageUrl,
                            userName: challenge.evaluatorName,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kPaddingValue * 1,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'What you have to do:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kSmallPaddingValue,
                    ),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                        ),
                      ),
                    ),
                    RoundedButton(
                      onTap: () async {
                        String path = "${challenge.parcId}/${challenge.evaluatorUid}";

                        await challengeProvider.getReadyForTheChallenge(
                          isEvaluator: customUser.uid == challenge.evaluatorUid,
                          path: path,
                        );
                        setState(() {
                          buttonAnimation = !buttonAnimation;
                        });
                      },
                      text: buttonAnimation ? "Ready" : "Not ready yet",
                      shouldAnimate: buttonAnimation,
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
