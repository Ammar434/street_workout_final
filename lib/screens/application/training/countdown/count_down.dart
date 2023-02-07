import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../widgets/app_bar.dart';
import 'components/countdown_body.dart';
import 'components/countdown_button.dart';

class CountDownScreen extends StatefulWidget {
  const CountDownScreen({Key? key}) : super(key: key);

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  int duration = 25;
  bool isSoundPlaying = false;
  final CountDownController _controller = CountDownController();

  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.text = duration.toString();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Timer"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CountDownBody(
              duration: duration,
              controller: _controller,
              playingSound: isSoundPlaying,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        int value = int.parse(textController.text);
                        value = value - 1;
                        setState(() {
                          duration = value;
                          // _controller.restart(duration: duration);
                        });

                        if (value < 0) {
                          value = 0;
                        }
                        textController.text = value.toString();
                      },
                      icon: const FaIcon(FontAwesomeIcons.minus),
                    ),
                    SizedBox(
                      width: 100.sp,
                      child: TextField(
                        controller: textController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        int value = int.parse(textController.text);
                        value = value + 1;
                        setState(() {
                          duration = value;
                          // _controller.restart();
                        });

                        textController.text = value.toString();
                      },
                      icon: const FaIcon(FontAwesomeIcons.plus),
                    ),
                  ],
                ),
                SizedBox(
                  height: kPaddingValue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isSoundPlaying,
                      onChanged: (b) {
                        setState(() {
                          isSoundPlaying = !isSoundPlaying;
                        });
                      },
                    ),
                    SizedBox(
                      width: kPaddingValue * 2,
                    ),
                    Text(
                      "Play sound",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CountDownButton(
                  title: "Start",
                  onPressed: () {
                    // print(duration);
                    _controller.restart(duration: duration);
                  },
                ),
                CountDownButton(title: "Pause", onPressed: () => _controller.pause()),
                CountDownButton(title: "Resume", onPressed: () => _controller.resume()),
                CountDownButton(title: "Restart", onPressed: () => _controller.restart(duration: duration)),
              ],
            ),
            SizedBox(
              height: kPaddingValue,
            ),
          ],
        ),
      ),
    );
  }
}
