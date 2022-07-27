import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_start/components/bottom_challenge_screen.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';

import '../../../../widgets/app_bar.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);
  static String name = "ChallengeScreen";

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final RealtimeDatabaseMethods realtimeDatabaseMethods = RealtimeDatabaseMethods();
  bool flag = true;
  bool isRating = false;
  bool isEvaluatorListEmpty = false;
  List<Challenge> listChallenge = [];
  late CustomUser customUser;
  void challengerFunction() {
    animationController.forward().whenComplete(
      () {
        setState(
          () {
            isEvaluatorListEmpty = listChallenge.isEmpty;
            animationController.reset();
          },
        );
        if (isEvaluatorListEmpty) {
          Future.delayed(const Duration(seconds: 3)).whenComplete(() {
            setState(() {
              flag = !flag;
            });
          });
        }
      },
    );
    setState(() {
      flag = !flag;
    });
  }

  void evaluatorFunction() async {
    setState(() {
      isRating = true;
    });
    await RealtimeDatabaseMethods().createParcReference(
      customUser.favoriteParc,
      customUser.uid,
    );
    debugPrint("evaluator finish");
  }

  Future<void> deleteData() async {
    await RealtimeDatabaseMethods().deleteParcReference(
      customUser.favoriteParc,
      customUser.uid,
    );

    // Provider.of<ChallengeProvider>(context, listen: false).removeListChallenge();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    deleteData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    customUser = Provider.of<UserProvider>(context).getUser;
    listChallenge = Provider.of<ChallengeProvider>(context).listChallenge;

    return Scaffold(
      appBar: buildAppBar(context, "Challenge"),
      body: Column(
        children: [
          Expanded(
            child: Lottie.network(
              "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json",
              controller: animationController,
            ),
          ),
          // Consumer<ChallengeProvider>(
          //   builder: (context, value, child) {
          //     return Expanded(
          //       child: ListView.builder(
          //         itemCount: listChallenge.length,
          //         itemBuilder: (context, index) => ListTile(
          //           // leading: CircleAvatar(backgroundImage: NetworkImage(listChallenge[index].challenger!.profileImage)),
          //           title: Text(listChallenge[index].evaluatorUid),
          //           trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          //         ),
          //       ),
          //     );
          //   },
          // ),

          BottomPartChallengeScreen(
            customUser: customUser,
            flag: flag,
            challengerOnTap: challengerFunction,
            evaluatorOnTap: evaluatorFunction,
            isEvaluatorFound: isEvaluatorListEmpty,
            listChallenge: listChallenge,
          )
        ],
      ),
    );
  }
}
