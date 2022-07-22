import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/main_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CustomUser customUser =      Provider.of<UserProvider>(context).getUser;
    return const MainScreen();
  }
}
