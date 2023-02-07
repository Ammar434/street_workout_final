import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../widgets/snackbar.dart';
import '../../achievement_screen/achievement_screen.dart';
import 'drawer_categorie_tile.dart';

class DrawerCategorieWidget extends StatelessWidget {
  const DrawerCategorieWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
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
          iconData: FontAwesomeIcons.gamepad,
          text: "Statistique",
          onTap: () {
            showSnackbarBuildLater(globalKey: scaffoldKey);
            // Navigator.pushNamed(context, FavoriteParcEmptyScreen.name);
          },
        ),
      ],
    );
  }
}
