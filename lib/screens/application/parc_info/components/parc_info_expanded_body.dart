import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ParcInfoExpandedBody extends StatelessWidget {
  const ParcInfoExpandedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      TyperAnimatedText(
                        'He who is not courageous enough to take risks will accomplish nothing in life.\n<<Muhammad Ali>>',
                        textAlign: TextAlign.center,
                      ),
                      TyperAnimatedText(
                        "Today I will do what others won't, so tomorrow I can accomplish what others can't.\n<<Jerry Rice>>",
                        textAlign: TextAlign.center,
                      ),
                      TyperAnimatedText(
                        "We are what we repeatedly do. Excellence, therefore, is not an act but a habit.\n<<Aristotle>>",
                        textAlign: TextAlign.center,
                      ),
                      TyperAnimatedText(
                        'Keep calm and do calisthenics\n<<Unknown>>',
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
