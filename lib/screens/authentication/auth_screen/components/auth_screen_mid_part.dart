import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/text_style.dart';

class AuthScreenMidPart extends StatelessWidget {
  const AuthScreenMidPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Europe’s #1 fitness app",
          style: kTextStyleImportance3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Whatever your fitness level, achieve your goals quickly and build healthy habits with our app",
          style: kTextStyleHintText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
