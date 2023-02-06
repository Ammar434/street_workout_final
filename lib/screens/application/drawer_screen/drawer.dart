import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/geolocalisation/geolocalisation.dart';

import '../achievement_screen/add_new_achievement/add_new_achievement.dart';
import '../post_screen/post_screen.dart';
import 'components/drawer_bottom_widget.dart';
import 'components/drawer_categorie_tile.dart';
import 'components/drawer_categorie_widget.dart';
import 'components/drawer_top_widget.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  late Geolocalisation geolocalisation;
  late Position currentPosition;
  String currentUserCity = "unknown";
  bool isLoading = true;

  Future<void> loadData() async {
    currentPosition = await geolocalisation.determinePosition();
    currentUserCity = await geolocalisation.reverseGeocoding(currentPosition);
    if (currentUserCity == "") {
      currentUserCity = "unknown";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    geolocalisation = Geolocalisation();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerTopWidget(
            profileImage: customUser.profileImage,
            userName: customUser.userName,
            userUid: customUser.uid,
            userCity: currentUserCity,
            isLoading: isLoading,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          const HorizontalLine(),
          const DrawerCategorieWidget(),
          const HorizontalLine(),
          const DrawerBottomWidget(),
          const HorizontalLine(),
          DrawerCategorieTile(
            iconData: FontAwesomeIcons.calendar,
            text: "Add new parc",
            onTap: () {
              Navigator.pushNamed(context, PostScreen.name);
            },
          ),
          DrawerCategorieTile(
            iconData: FontAwesomeIcons.calendar,
            text: "Add new reward",
            onTap: () {
              Navigator.pushNamed(context, AddNewAchievement.name);
            },
          ),
        ],
      ),
    );
  }
}
