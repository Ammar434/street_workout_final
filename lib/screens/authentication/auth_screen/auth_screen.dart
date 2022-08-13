import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'components/auth_screen_bottom_part.dart';
import 'components/auth_screen_mid_part.dart';
import 'components/auth_screen_top_part.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              AuthScreenTopPart(),
              AuthScreenMidPart(),
              AuthScreenBottomPart(),
            ],
          ),
        ),
      ),
    );
  }
}
