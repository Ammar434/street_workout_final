import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/text_field_input.dart';

import 'recover_password_confirm_screen.dart';

class RecoverPasswordScreen extends StatefulWidget {
  static String name = "RecoverPasswordScreen";

  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildColumnHeader(context),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              RoundedButton(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RecoverPasswordConfirmScreen.name);
                },
                text: "Reset",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumnHeader(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3 / 2.5,
          child: Image.asset(
            "assets/images/authentication/image5_authentication.png",
          ),
        ),
        const Text(
          "Did someone forget their password?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "That's ok... Just enter the email address you've used to register with us and we'll send you a reset link!",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
