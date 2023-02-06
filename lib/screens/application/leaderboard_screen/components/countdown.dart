import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../utils/constants.dart';

class Countdown extends StatelessWidget {
  const Countdown({
    super.key,
    required this.duration,
  });
  final Duration? duration;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kPaddingValue),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              key: const Key('1'),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(kPaddingValue),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LottieBuilder.network(
                    "https://assets1.lottiefiles.com/packages/lf20_wsccbfdk.json",
                    height: kPaddingValue * 15,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    "Free calisthenic gear for the top athlete",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      // color: backgroundColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "When the countdown ends, the top three athletes will receive a mystery gift with a minimum value of €25.",
                    style: TextStyle(
                      fontSize: 14,
                      // color: backgroundColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                    "You can improve your ranking by completing challenges and by adding new parks.",
                    style: TextStyle(
                      fontSize: 14,
                      // color: backgroundColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Start working",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: SlideCountdown(
        duration: duration,
        separatorType: SeparatorType.title,
        slideDirection: SlideDirection.down,
      ),
    );
  }
}
