import 'package:flutter/material.dart';

import "../../../../common_libs.dart";
import '../../../../widgets/text_field_input.dart';

class LoginScreenBodyInput extends StatelessWidget {
  const LoginScreenBodyInput({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextFieldInput(
            textEditingController: emailController,
            hintText: "Email",
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          TextFieldInput(
            textEditingController: passwordController,
            hintText: "Password",
            textInputType: TextInputType.visiblePassword,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
