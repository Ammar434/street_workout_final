import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/constants.dart';

class DrawerCategorieTile extends StatelessWidget {
  DrawerCategorieTile({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPaddingValue),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          textBaseline: TextBaseline.ideographic,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: FaIcon(
                iconData,
                size: 26,
              ),
            ),
            SizedBox(
              width: kPaddingValue * 1.5,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
