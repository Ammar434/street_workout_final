import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_screen.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';

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
          text: "Achievements",
          onTap: () {
            Navigator.pushNamed(context, AchievementScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add new parc",
          onTap: () {
            Navigator.pushNamed(context, PostScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.briefcase,
          text: "Start a training",
          onTap: () {},
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Start a challenge",
          onTap: () {
            Navigator.pushNamed(context, ChallengeScreen.name);
          },
        ),
      ],
    );
  }
}
