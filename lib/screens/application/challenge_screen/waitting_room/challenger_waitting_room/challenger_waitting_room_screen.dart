import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/challenge_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
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

  int searchingDurationSecond = 5;
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
        animationController.stop();
        setState(
          () {
            flag = !flag;
          },
        );
      },
    );
  }

  void disposeData() async {
    await challengeProvider.deleteRoom(true);
    animationController.stop();
    animationController.dispose();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      ),
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
              if (flag) {
                Navigator.of(context).pop();
              } else {
                animationController.repeat();
                timer = Timer(
                  Duration(
                    seconds: searchingDurationSecond,
                  ),
                  () {
                    animationController.stop();
                    setState(
                      () {
                        flag = !flag;
                      },
                    );
                  },
                );
                setState(() {
                  flag = !flag;
                });
              }
            },
            child: Text(
              flag ? "Stop" : "Retry",
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
