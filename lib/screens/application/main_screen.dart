import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'home_screen/home/home_screen.dart';
import 'map_screen/map_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Zoom();
  }
}

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  ZoomState createState() => ZoomState();
}

class ZoomState extends State<Zoom> {
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
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          backgroundColor: Colors.indigo,
          body: Padding(
            padding: EdgeInsets.only(left: 25),
            //Drawer widget
            child: Center(
              child: Text(
                'kkkk',
                // style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
      // extendBodyBehindAppBar: true,
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
        children: [
          const HomeScreen(),
          const MapScreen(),
          Container(
            color: Colors.brown,
            child: const Center(
              child: Text(
                "Back Panel",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.brown,
            child: const Center(
              child: Text(
                "Back Panel",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.brown,
            child: const Center(
              child: Text(
                "Back Panel",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 65,
        onTap: (value) {
          setState(
            () => index = value,
          );
        },
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.location_on),
          Icon(Icons.add),
          Icon(Icons.leaderboard),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}
