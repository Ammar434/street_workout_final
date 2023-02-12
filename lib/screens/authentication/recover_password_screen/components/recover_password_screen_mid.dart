import 'package:flutter/material.dart';

import '../../../../common_libs.dart';

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
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kPaddingValue * 2,
        ),
        Text(
          "That's ok... Just enter the email address you've used to register with us and we'll send you a reset link!",
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
