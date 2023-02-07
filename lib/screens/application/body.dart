import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_screen/home_screen.dart';
import 'leaderboard_screen/leaderboard_screen.dart';
import 'main_screen.dart';
import 'map_screen/map_screen.dart';
import 'settings_screen/settings_screen.dart';

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
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: (index != 2 && index != 1)
          ? AppBar(
              title: Text(
                "Fit Fighter",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  z.toggle!();
                },
              ),
            )
          : null,
      body: IndexedStack(
        index: index,
        children: const [
          HomeScreen(),
          MapScreen(),
          LeaderboardScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        color: Theme.of(context).colorScheme.secondaryContainer,
        height: 56.sp,
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
