import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../favorite_parc/favorite_parc_empty_screen.dart';
import '../../achievement_screen/achievement_screen.dart';

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
          text: "Rewards",
          onTap: () {
            Navigator.pushNamed(context, AchievementScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.chartLine,
          text: "Statistique",
          onTap: () {
            Navigator.pushNamed(context, FavoriteParcEmptyScreen.name);
          },
        ),
      ],
    );
  }
}
