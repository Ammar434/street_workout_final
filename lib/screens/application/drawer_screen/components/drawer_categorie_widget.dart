import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/favorite_parc/favorite_parc_screen.dart';
import '../../achievement_screen/achievement_screen.dart';
import '../../post_screen/post_screen.dart';

import 'drawer_categorie_tile.dart';

class DrawerCategorieWidget extends StatelessWidget {
  const DrawerCategorieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.gem,
          text: "Achievements",
          onTap: () {
            Navigator.pushNamed(context, AchievementScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.trophy,
          text: "Favorite parc",
          onTap: () {
            Navigator.pushNamed(context, FavoriteParcScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add new parc",
          onTap: () {
            Navigator.pushNamed(context, PostScreen.name);
          },
        ),
      ],
    );
  }
}
