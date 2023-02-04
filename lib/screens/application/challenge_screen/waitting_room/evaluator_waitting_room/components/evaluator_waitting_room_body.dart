import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/widgets/app_bar.dart';

import '../../../../../../provider/challenge_provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../widgets/loading_widget.dart';

class EvaluatorWaittingRoomScreenBody extends StatefulWidget {
  const EvaluatorWaittingRoomScreenBody({Key? key}) : super(key: key);
  @override
  State<EvaluatorWaittingRoomScreenBody> createState() => _EvaluatorWaittingRoomScreenBodyState();
}

class _EvaluatorWaittingRoomScreenBodyState extends State<EvaluatorWaittingRoomScreenBody> {
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
      (timer) async {
        if (timeDuration > 0) {
          setState(() {
            timeDuration--;
          });
        } else {
          // await challengeProvider.deleteRoom(false);

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

  void disposeData() async {
    await challengeProvider.deleteRoom(false);
    timer.cancel();
  }

  @override
  void deactivate() {
    disposeData();
    super.deactivate();
  }

  @override
  void dispose() {
    disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: isLoading ? const LoadingWidget() : buildColumn(context),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
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
                  "Finding evaluator arround you",
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
                onEnd: () {
                  disposeData();
                  Navigator.pop(context);
                },
                child: Text(
                  "No one whan't to do a challenge arround you for the moment. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultTitleSize * 0.75,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              disposeData();
              Navigator.pop(context);
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