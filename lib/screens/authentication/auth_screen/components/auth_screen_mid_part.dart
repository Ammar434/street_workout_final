import 'package:flutter/material.dart';

import '../../../../common_libs.dart';

class AuthScreenMidPart extends StatelessWidget {
  const AuthScreenMidPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Europe’s #1 fitness app",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kPaddingValue * 2,
        ),
        Text(
          "Whatever your fitness level, achieve your goals quickly and build healthy habits with our app",
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
