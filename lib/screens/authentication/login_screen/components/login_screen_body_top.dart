import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';

class LoginScreenBodyTop extends StatelessWidget {
  const LoginScreenBodyTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Let's sign you in",
          style: kTextStyleImportance1,
        ),
        Text(
          "Welcome back, you've been missed!",
          style: kTextStyleImportance2,
        ),
        SizedBox(
          height: kPaddingValue * 5,
        ),
      ],
    );
  }
}
