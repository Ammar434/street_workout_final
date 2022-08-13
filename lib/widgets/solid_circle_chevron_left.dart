import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SolidCircleChevronLeft extends StatelessWidget {
  SolidCircleChevronLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: FaIcon(
        FontAwesomeIcons.chevronLeft,
        size: 20,
        // color: isLike ? primaryColor : Colors.black87,
      ),
    );
  }
}
