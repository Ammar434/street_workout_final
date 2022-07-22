import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:street_workout_final/screens/application/drawer_screen/drawer.dart';
import 'package:street_workout_final/services/geolocalisation/geolocalisation.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'body.dart';

final ZoomDrawerController z = ZoomDrawerController();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String name = "MainScreen";

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late Position currentPosition;
  late String currentUserCity;
  bool isLoading = true;
  Future<void> loadData() async {
    currentPosition = await Geolocalisation().determinePosition();
    currentUserCity = await Geolocalisation().reverseGeocoding(currentPosition);
    debugPrint(currentPosition.latitude.toString());
    debugPrint(currentPosition.longitude.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : ZoomDrawer(
            controller: z,
            borderRadius: 24,
            style: DrawerStyle.defaultStyle,
            drawerShadowsBackgroundColor: tertiaryColor,
            showShadow: true,
            menuBackgroundColor: backgroundColor,
            openCurve: Curves.fastOutSlowIn,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            duration: const Duration(milliseconds: 500),
            angle: 0.0,
            mainScreen: const Body(),
            menuScreen: DrawerBody(
              userCity: currentUserCity,
            ),
          );
  }
}
