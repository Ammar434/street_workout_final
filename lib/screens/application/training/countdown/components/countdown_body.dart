import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:street_workout_final/common_libs.dart";

class CountDownBody extends StatelessWidget {
  const CountDownBody({
    Key? key,
    required this.duration,
    required this.controller,
    required this.playingSound,
  }) : super(key: key);

  final int duration;
  final CountDownController controller;
  final bool playingSound;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: duration,
      initialDuration: 0,

      controller: controller,

      width: MediaQuery.of(context).size.width / 2,

      height: MediaQuery.of(context).size.height / 2,

      ringColor: Theme.of(context).highlightColor,

      fillColor: Theme.of(context).colorScheme.secondary,

      backgroundColor: Theme.of(context).primaryColor,

      strokeWidth: kPaddingValue,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.square,

      // Text Style for Countdown Text.
      textStyle: Theme.of(context).textTheme.titleLarge,

      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: false,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: false,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: false,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        debugPrint('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        // Here, do whatever you want
        controller.reset();
        if (playingSound == true) {
          SystemSound.play(SystemSoundType.click);
        }

        debugPrint('Countdown Ended');
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {
        // Here, do whatever you want
        debugPrint('Countdown Changed $timeStamp');
      },

      /* 
        * Function to format the text.
        * Allows you to format the current duration to any String.
        * It also provides the default function in case you want to format specific moments
          as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
          the default behavior.
      */
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          // only format for '0'
          return "Start";
        } else {
          // other durations by it's default format
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
