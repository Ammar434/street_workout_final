import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';

import '../../achievement_screen/add_new_achievement/add_new_achievement.dart';
import 'drawer_categorie_tile.dart';

class DrawerAddingPart extends StatelessWidget {
  const DrawerAddingPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.locationDot,
          text: "Add new parc",
          onTap: () {
            Navigator.pushNamed(context, PostScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.award,
          text: "Add new reward",
          onTap: () {
            Navigator.pushNamed(context, AddNewAchievement.name);
          },
        ),
      ],
    );
  }
}
