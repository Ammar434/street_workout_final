import 'package:flutter/material.dart';

import '../screens/authentication/auth_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MainScreen();
    return const AuthScreen();
  }
}
