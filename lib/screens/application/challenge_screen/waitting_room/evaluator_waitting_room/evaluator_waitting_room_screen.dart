import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/app_bar.dart';
import '../../../../../widgets/loading_widget.dart';

class EvaluatorWaittingRoomScreen extends StatefulWidget {
  const EvaluatorWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "EvaluatorWaittingRoomScreen";

  @override
  State<EvaluatorWaittingRoomScreen> createState() => _EvaluatorWaittingRoomScreenState();
}

class _EvaluatorWaittingRoomScreenState extends State<EvaluatorWaittingRoomScreen> {
  late ChallengeProvider challengeProvider;

  late Timer timer;
  bool isChallengerFound = false;
  int timeDuration = 15;
  int timeDurationInitial = 15;
  bool isLoading = false;
  double opacityLevel = 0.0;
  Color timerColor = Colors.white;

  void changeOpacity() {
    setState(
      () => opacityLevel = 1.0,
    );
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeDuration > 0) {
          setState(() {
            timeDuration--;
          });
        } else {
          changeOpacity();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
    startTimer();

    //Etape 1 creer la room:

    //Etape 2  envoyer vers la page de waitting room

    //Etape 3 affiché le message de prevention

    //Etape 4 emmene vers la page du challenge
  }

  @override
  void dispose() {
    // _realtimeDatabaseMethods.deleteParcReference(
    //   _customUser.favoriteParc,
    //   _customUser.uid,
    // );
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: isLoading
          ? const LoadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      size: kDefaultIconsSize,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: kPaddingValue,
                    ),
                    Text(
                      "Wait time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultTitleSize * 0.75,
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation(timerColor),
                              backgroundColor: primaryColor,
                              value: 1 - timeDuration / timeDurationInitial,
                            ),
                            buildTimer()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kPaddingValue,
                      ),
                      AnimatedOpacity(
                        opacity: 1 - opacityLevel,
                        duration: const Duration(seconds: 1),
                        child: Text(
                          "Finding athletes arround you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kDefaultTitleSize * 0.75,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: opacityLevel,
                        duration: const Duration(seconds: 5),
                        curve: Curves.linearToEaseOut,
                        child: Text(
                          "The athlete who was to be evaluated failed to join the challenge. Please try again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kDefaultTitleSize * 0.75,
                          ),
                        ),
                        onEnd: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Stop challenge",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultTitleSize * 0.75,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildTimer() {
    if (timeDuration > 0) {
      return Center(
        child: Text(
          timeDuration.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: kDefaultTitleSize * 3,
            // color: primaryColor,
          ),
        ),
      );
    } else {
      if (isChallengerFound) {
        return Center(
          child: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.greenAccent,
            size: kDefaultTitleSize * 3,
          ),
        );
      } else {
        return Center(
          child: FaIcon(
            FontAwesomeIcons.xmark,
            color: Colors.redAccent,
            size: kDefaultTitleSize * 3,
          ),
        );
      }
    }
  }
}
