import 'package:flutter/material.dart';

import "../../../common_libs.dart";
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(child: SizedBox()),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  "assets/images/authentication/image6_authentication.png",
                ),
              ),
              Column(
                children: [
                  Text(
                    "Password reset e-mail has been sent",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "A password reset email has been sent to your e-mail address.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
}
