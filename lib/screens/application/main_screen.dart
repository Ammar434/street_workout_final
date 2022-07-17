import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:street_workout_final/screens/application/drawer_screen/drawer.dart';
import 'body.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String name = "MainScreen";

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      mainScreen: const Body(),
      menuScreen: const DrawerBody(),
    );
  }
}
