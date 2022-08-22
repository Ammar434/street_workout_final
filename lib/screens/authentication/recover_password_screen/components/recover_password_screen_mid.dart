import 'package:flutter/material.dart';

import '../../../../utils/text_style.dart';

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
          style: kTextStyleImportance3,
          textAlign: TextAlign.center,
        ),
        Text(
          "That's ok... Just enter the email address you've used to register with us and we'll send you a reset link!",
          style: kTextStyleHintTextImportance3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
