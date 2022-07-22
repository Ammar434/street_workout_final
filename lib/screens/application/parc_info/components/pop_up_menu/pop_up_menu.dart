import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget(
      {Key? key, required this.menuList, this.icon, required this.child})
      : super(key: key);
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusValue),
      ),
      color: iconColor,
      itemBuilder: (BuildContext context) {
        return menuList;
      },
      // icon: icon,
      child: child,
    );
  }
}
