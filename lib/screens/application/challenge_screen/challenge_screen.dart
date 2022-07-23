import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/app_bar.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key? key}) : super(key: key);
  static String name = "ChallengeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Challenge"),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Lottie.network(
                "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json"),
          ),
          Expanded(
            child: SizedBox(
              // color: Colors.amber,
              width: double.infinity,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16.0,

                  // fontFamily: GoogleFonts.,
                ),
                child: Center(
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      FlickerAnimatedText(
                        'He who is not courageous enough to take risks will accomplish nothing in life. <<Muhammad Ali>>',
                        textAlign: TextAlign.center,
                        speed: const Duration(seconds: 5),
                      ),
                      FlickerAnimatedText(
                        "Today I will do what others won't, so tomorrow I can accomplish what others can't. <<Jerry Rice>>",
                        speed: const Duration(seconds: 5),
                        textAlign: TextAlign.center,
                      ),
                      FlickerAnimatedText(
                        "We are what we repeatedly do. Excellence, therefore, is not an act but a habit. <<Aristotle>>",
                        speed: const Duration(seconds: 5),
                        textAlign: TextAlign.center,
                      ),
                      FlickerAnimatedText(
                        'Keep calm and do calisthenics\n<<Unknown>>',
                        speed: const Duration(seconds: 5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    onTap: () {
                      // print("Tap Event");
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
