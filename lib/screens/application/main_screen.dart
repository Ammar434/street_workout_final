import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import "../../common_libs.dart";
import 'body.dart';
import 'drawer_screen/drawer.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String name = "MainScreen";

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: kRadiusValue,
      style: DrawerStyle.defaultStyle,
      drawerShadowsBackgroundColor: Theme.of(context).splashColor,
      showShadow: true,
      menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      mainScreen: const Body(),
      menuScreen: const DrawerBody(),
    );
  }
}
