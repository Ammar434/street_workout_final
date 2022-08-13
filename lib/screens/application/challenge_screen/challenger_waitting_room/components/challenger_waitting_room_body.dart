import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenger_waitting_room/components/challenge_is_start_widget.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';

class ChallengerWaittingRoomBody extends StatefulWidget {
  ChallengerWaittingRoomBody({Key? key}) : super(key: key);
  @override
  State<ChallengerWaittingRoomBody> createState() => _ChallengerWaittingRoomBodyState();
}

class _ChallengerWaittingRoomBodyState extends State<ChallengerWaittingRoomBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  int searchingDuration = 15;
  bool flag = true;
  late Future t;
  Widget _renderWidget() {
    if (flag) {
      return ChallengeIsStartWidget();
    } else {
      return Text(
        "The athlete who was to be evaluated failed to join the challenge. Please try again.",
        textAlign: TextAlign.center,
        key: Key("2"),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: kDefaultTitleSize * 0.75,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    t = Future.delayed(Duration(seconds: searchingDuration)).whenComplete(() {
      animationController.stop();
      setState(() {
        flag = !flag;
        Future.delayed(Duration(seconds: 5)).whenComplete(
          () => Navigator.of(context).pop(),
        );
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
              duration: Duration(seconds: 1),
              child: _renderWidget(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Stop rating",
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
}
