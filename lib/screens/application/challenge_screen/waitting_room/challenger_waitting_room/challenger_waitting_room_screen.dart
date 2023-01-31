import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/app_bar.dart';
import 'components/challenge_is_start_widget.dart';

class ChallengerWaittinRoomScreen extends StatefulWidget {
  const ChallengerWaittinRoomScreen({Key? key}) : super(key: key);
  static String name = "ChallengerWaittinRoomScreen";

  @override
  State<ChallengerWaittinRoomScreen> createState() => _ChallengerWaittinRoomScreenState();
}

class _ChallengerWaittinRoomScreenState extends State<ChallengerWaittinRoomScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late ChallengeProvider challengeProvider;

  int searchingDurationSecond = 10;
  bool flag = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
    animationController = AnimationController(vsync: this);
    timer = Timer(
      Duration(
        seconds: searchingDurationSecond,
      ),
      () {
        setState(
          () async {
            flag = !flag;
            if (timer.isActive) {
              // animationController.stop();
              await challengeProvider.deleteRoom(true);
              Future.delayed(const Duration(seconds: 5)).whenComplete(
                () => Navigator.of(context).pop(),
              );
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.stop();
    animationController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Lottie.network(
              "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json",
              controller: animationController,
              onLoaded: (composition) {
                animationController.duration = composition.duration;
                animationController.repeat();
              },
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              duration: const Duration(seconds: 1),
              child: _renderWidget(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Stop",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: kDefaultTitleSize * 0.75,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
        ],
      ),
    );
  }

  Widget _renderWidget() {
    if (flag) {
      return const ChallengeIsStartWidget();
    } else {
      return Text(
        "No evaluator arround you for the moment. Please retry or send us your video",
        textAlign: TextAlign.center,
        key: const Key("2"),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: kDefaultTitleSize * 0.75,
        ),
      );
    }
  }
}
