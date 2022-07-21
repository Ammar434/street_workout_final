import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
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
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerTopWidget(
            profileImage: customUser.profileImage,
            userName: customUser.userName,
            userUid: customUser.uid,
          ),
          const HorizontalLine(),
          const DrawerCategorieWidget(),
          const HorizontalLine(),
          const DrawerBottomWidget(),
        ],
      ),
    );
  }
}
