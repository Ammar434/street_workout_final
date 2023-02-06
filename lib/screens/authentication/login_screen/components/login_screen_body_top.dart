import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";


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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Welcome back, you've been missed!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: kPaddingValue * 5,
        ),
      ],
    );
  }
}
