import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'drawer_screen/drawer.dart';
import '../../utils/colors.dart';
import 'body.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  static String name = "MainScreen";

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
      drawerShadowsBackgroundColor: tertiaryColor,
      showShadow: true,
      menuBackgroundColor: backgroundColor,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: Duration(milliseconds: 500),
      angle: 0.0,
      mainScreen: Body(),
      menuScreen: DrawerBody(),
    );
  }
}
