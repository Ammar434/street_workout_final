import 'package:flutter/material.dart';

import "../../../../common_libs.dart";
import 'login_screen_body_bottom.dart';
import 'login_screen_body_input.dart';
import 'login_screen_body_top.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.loginUser,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final GestureTapCallback loginUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const LoginScreenBodyTop(),
            LoginScreenBodyInput(
              emailController: emailController,
              passwordController: passwordController,
            ),

            LoginScreenBodyBottom(
              isLoading: isLoading,
              loginUser: loginUser,
            ),
          ],
        ),
      ),
    );
  }
}
