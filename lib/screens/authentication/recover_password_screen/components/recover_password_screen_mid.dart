import 'package:flutter/material.dart';


class RecoverPasswordScreenMid extends StatelessWidget {
  const RecoverPasswordScreenMid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Did someone forget their password?",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          "That's ok... Just enter the email address you've used to register with us and we'll send you a reset link!",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
