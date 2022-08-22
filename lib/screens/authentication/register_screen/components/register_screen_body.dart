import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'register_screen_body_input.dart';
import 'register_screen_body_top.dart';
import '../../../../widgets/rounded_button.dart';
import '../../../../utils/constants.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({
    Key? key,
    required this.selectImage,
    required this.image,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.userNameController,
    required this.onPageTransition,
    required this.isLoading,
  }) : super(key: key);

  final GestureTapCallback selectImage;
  final Uint8List image;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController userNameController;

  final GestureTapCallback onPageTransition;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RegisterScreenBodyTop(image: image, selectImage: selectImage),
                RegisterScreenBodyInput(
                  emailController: emailController,
                  userNameController: userNameController,
                  passwordController: passwordController,
                  passwordConfirmController: passwordConfirmController,
                ),
                RoundedButton(
                  onTap: onPageTransition,
                  text: "Register",
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
