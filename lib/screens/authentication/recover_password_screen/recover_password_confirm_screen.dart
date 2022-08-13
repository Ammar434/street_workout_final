import 'package:flutter/material.dart';

import 'package:street_workout_final/utils/constants.dart';
import '../../../widgets/rounded_button.dart';

class RecoverPasswordConfirmScreen extends StatelessWidget {
  static String name = "RecoverPasswordConfirmScreen";

  const RecoverPasswordConfirmScreen({Key? key}) : super(key: key);

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
              RoundedButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                },
                text: "Okay",
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
            "assets/images/authentication/image6_authentication.png",
          ),
        ),
        const Text(
          "Password reset e-mail has been sent",
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
          "A password reset email has been sent to your e-mail address.",
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
