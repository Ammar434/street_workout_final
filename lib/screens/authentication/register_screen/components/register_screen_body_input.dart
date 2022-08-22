import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/text_field_input.dart';

class RegisterScreenBodyInput extends StatelessWidget {
  const RegisterScreenBodyInput({
    Key? key,
    required this.emailController,
    required this.userNameController,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          textEditingController: userNameController,
          hintText: "Username",
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
        SizedBox(
          height: kPaddingValue,
        ),
        TextFieldInput(
          textEditingController: passwordConfirmController,
          hintText: "Confirm Password",
          textInputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
      ],
    );
  }
}
