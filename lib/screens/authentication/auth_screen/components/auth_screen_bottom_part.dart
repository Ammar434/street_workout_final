import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../login_screen/login_screen.dart';
import '../../register_screen/register_screen.dart';

class AuthScreenBottomPart extends StatelessWidget {
  const AuthScreenBottomPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.name);
            },
            child: Container(
              height: kDefaultButtonSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRadiusValue),
                  bottomLeft: Radius.circular(kRadiusValue),
                ),
              ),
              child: Center(
                child: Text(
                  "Register",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.name);
            },
            child: Container(
              height: kDefaultButtonSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    kRadiusValue,
                  ),
                  bottomRight: Radius.circular(
                    kRadiusValue,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Log In",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
