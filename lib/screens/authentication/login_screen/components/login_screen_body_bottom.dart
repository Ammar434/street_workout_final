import 'package:flutter/material.dart';
import '../../recover_password_screen/recover_password_screen.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_style.dart';
import '../../../../widgets/rounded_button.dart';

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
