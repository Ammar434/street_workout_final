import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';

class SolidCircleIcon extends StatelessWidget {
  const SolidCircleIcon({Key? key, required this.iconData}) : super(key: key);
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: kRadiusValueImageProfile / 3,
      backgroundColor: Colors.white,
      child: FaIcon(
        iconData,
        size: kDefaultIconsSize,
        // color: isLike ? primaryColor : Colors.black87,
      ),
    );
  }
}
