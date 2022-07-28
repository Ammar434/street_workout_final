import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_start/components/bottom_challenge_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import 'package:street_workout_final/screens/application/favorite_parc/favorite_parc_screen.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'package:street_workout_final/widgets/snackbar.dart';

import '../../../../widgets/app_bar.dart';

class ChallengeStartScreen extends StatefulWidget {
  const ChallengeStartScreen({Key? key}) : super(key: key);
  static String name = "ChallengeStartScreen";

  @override
  State<ChallengeStartScreen> createState() => _ChallengeStartScreenState();
}

class _ChallengeStartScreenState extends State<ChallengeStartScreen> with SingleTickerProviderStateMixin {
  final RealtimeDatabaseMethods realtimeDatabaseMethods = RealtimeDatabaseMethods();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late AnimationController animationController;
  late CustomUser currentUser;

  bool flag = true;
  bool isLoading = true;

  int searchingDuration = 15;

  void challengerFunction() {
    if (currentUser.favoriteParc.isEmpty) {
      Navigator.pushNamed(context, FavoriteParcScreen.name);
    } else {
      setState(() {
        flag = !flag;
      });
      animationController.repeat();
      Future.delayed(Duration(seconds: searchingDuration)).whenComplete(
        () {
          animationController.reset();
          animationController.stop();

          setState(() {
            flag = !flag;
          });
          customShowSnackBar(
            globalKey: _scaffoldKey,
            title: "No man's land",
            content: "No person arround found",
            contentType: ContentType.help,
          );
        },
      );
    }
  }

  void evaluatorFunction() async {
    if (currentUser.favoriteParc.isEmpty) {
      Navigator.pushNamed(context, FavoriteParcScreen.name);
    } else {
      Navigator.of(context).pushNamed(EvaluatorWaittingRoomScreen.name);
    }
  }

  void loadData() async {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
    await challengeProvider.listenToRoomComplete();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Challenge"),
      body: isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                Expanded(
                  child: Lottie.network(
                    "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json",
                    controller: animationController,
                    onLoaded: (composition) {
                      animationController.duration = composition.duration;
                    },
                  ),
                ),
                BottomPartChallengeScreen(
                  widgetToDisplay: flag,
                  challengerOnTap: challengerFunction,
                  evaluatorOnTap: evaluatorFunction,
                ),
              ],
            ),
    );
  }
}
