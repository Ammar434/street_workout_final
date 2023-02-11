import 'package:flutter/material.dart';

import '../screens/application/main_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserProvider>(context).refreshUser();
    // return AddNewAchievement();
    return const MainScreen();
  }
}
