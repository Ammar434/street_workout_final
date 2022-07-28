import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/constants.dart';

class GlobalWaittingRoomScreen extends StatelessWidget {
  const GlobalWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "GlobalWaittingRoomScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: kDefaultIconAppBar,
              ),
            ),
          ),
          title: const Text("Lobby"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Waitting room"),
            Text("We will develod this screen soon"),
          ],
        ),
      ),
    );
  }
}
