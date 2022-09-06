import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SolidCircleIcon extends StatelessWidget {
  const SolidCircleIcon({Key? key, required this.iconData, required this.iconSize}) : super(key: key);
  final IconData iconData;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: iconSize * 1,
      backgroundColor: Colors.white,
      child: FaIcon(
        iconData,
        size: iconSize,
        // color: isLike ? primaryColor : Colors.black87,
      ),
    );
  }
}
