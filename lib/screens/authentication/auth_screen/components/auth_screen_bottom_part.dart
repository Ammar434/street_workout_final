import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
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
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRadiusValue),
                  bottomLeft: Radius.circular(kRadiusValue),
                ),
              ),
              child: const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                color: primaryColor.withOpacity(0.75),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    kRadiusValue,
                  ),
                  bottomRight: Radius.circular(
                    kRadiusValue,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
