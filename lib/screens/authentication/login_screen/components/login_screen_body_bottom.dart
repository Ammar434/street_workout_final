import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/authentication/recover_password_screen/recover_password_screen.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

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
                style: kTextStyleImportance4..copyWith(color: primaryColor),
              ),
              SizedBox(
                width: kSmallPaddingValue,
              ),
              Text(
                "Restore",
                style: kTextStyleImportance4,
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
