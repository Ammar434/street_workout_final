import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/image1.png',
            height: 300,
            fit: BoxFit.contain,
          ),
        ),
        DefaultTextStyle(
          style: const TextStyle(
              fontWeight: FontWeight.w900, fontSize: kDefaultTitleSize),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                'It all started',
              ),
              WavyAnimatedText('with a pull up'),
            ],
            isRepeatingAnimation: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
