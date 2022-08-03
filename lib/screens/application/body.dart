import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';
import 'leaderboard_screen/leaderboard_screen.dart';
import 'settings_screen/settings_screen.dart';
import '../../utils/colors.dart';
import 'main_screen.dart';
import 'map_screen/map_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  int index = 0;

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Street Workout Fighters"),
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            z.toggle!();
          },
        ),
      ),
      body: IndexedStack(
        index: index,
        children: const [
          HomeScreen(),
          MapScreen(),
          LeaderboardScreen(),
          SettingsScreen()
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: primaryColor,
        color: primaryColor,
        height: 65,
        onTap: (value) {
          setState(
            () => index = value,
          );
        },
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.location_on),
          Icon(Icons.leaderboard),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}