import 'package:flutter/material.dart';
import '../screens/application/main_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    return MainScreen();
  }
}
