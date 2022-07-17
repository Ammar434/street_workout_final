import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class DrawerCategorieTile extends StatelessWidget {
  const DrawerCategorieTile({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingValue),
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
          const SizedBox(
            width: kPaddingValue * 1.5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
