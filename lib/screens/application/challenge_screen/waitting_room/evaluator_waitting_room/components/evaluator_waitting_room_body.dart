import 'dart:async';

import 'package:flutter/material.dart';
import "../../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../provider/challenge_provider.dart';
import '../../../../../../widgets/app_bar.dart';
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
            ),
            SizedBox(
              width: kPaddingValue,
            ),
            Text(
              "Wait time",
              style: Theme.of(context).textTheme.titleSmall,
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
                      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                  "Finding someone who whant to be evaluated",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
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
                  "No one whan't to do a challenge arround you for the moment. Please try later.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
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
              "Stop searching",
              style: Theme.of(context).textTheme.titleMedium,
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
            // color: Theme.of(context).colorScheme.secondary,
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
