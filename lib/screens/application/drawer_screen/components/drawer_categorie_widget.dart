import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';

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
          iconData: FontAwesomeIcons.trophy,
          text: "Rankings",
          onTap: () {},
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.gem,
          text: "Rewards",
          onTap: () {
            Navigator.pushNamed(context, AchievementScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add availability",
          onTap: () {},
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.briefcase,
          text: "My contribution",
          onTap: () {},
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add availability",
          onTap: () {},
        ),
      ],
    );
  }
}
