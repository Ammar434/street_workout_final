import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

import 'components/drawer_bottom_widget.dart';
import 'components/drawer_categorie_widget.dart';
import 'components/drawer_top_widget.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          DrawerTopWidget(),
          HorizontalLine(),
          DrawerCategorieWidget(),
          HorizontalLine(),
          DrawerBottomWidget(),
        ],
      ),
    );
  }
}
