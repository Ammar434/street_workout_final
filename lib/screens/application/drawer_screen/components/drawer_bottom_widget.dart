import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'drawer_categorie_tile.dart';

class DrawerBottomWidget extends StatelessWidget {
  const DrawerBottomWidget({
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
      ],
    );
  }
}
