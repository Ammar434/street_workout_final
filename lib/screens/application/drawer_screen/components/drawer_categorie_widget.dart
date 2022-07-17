import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'drawer_categorie_tile.dart';

class DrawerCategorieWidget extends StatelessWidget {
  const DrawerCategorieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.trophy,
          text: "Rankings",
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.gem,
          text: "Rewards",
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add availability",
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.briefcase,
          text: "My contribution",
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.calendar,
          text: "Add availability",
        ),
      ],
    );
  }
}
