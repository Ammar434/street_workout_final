import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/constants.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    leading: Center(
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.chevronLeft,
          size: kDefaultIconAppBar,
        ),
      ),
    ),
    title: Text(title),
  );
}
