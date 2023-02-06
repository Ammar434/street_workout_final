import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


AppBar buildAppBar(BuildContext context, String title, {List<Widget>? trailling}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: Center(
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          size: kDefaultIconAppBarSize,
        ),
      ),
    ),
    title: Text(title),
    actions: trailling ?? [],
  );
}
