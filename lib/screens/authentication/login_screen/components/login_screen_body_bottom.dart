import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../utils/text_style.dart';
import '../../../../widgets/rounded_button.dart';
import '../../recover_password_screen/recover_password_screen.dart';

class LoginScreenBodyBottom extends StatelessWidget {
  const LoginScreenBodyBottom({
    Key? key,
    required this.isLoading,
    required this.loginUser,
  }) : super(key: key);
  final bool isLoading;
  final GestureTapCallback loginUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RecoverPasswordScreen.name);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot your password?",
                style: TextThemeProvider().caption,
              ),
              SizedBox(
                width: kSmallPaddingValue,
              ),
              Text(
                "Restore",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        RoundedButton(
          onTap: loginUser,
          text: "Log in",
          isLoading: isLoading,
        ),
      ],
    );
  }
}
