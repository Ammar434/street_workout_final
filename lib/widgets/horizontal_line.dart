import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";


class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSmallPaddingValue * 2),
      child: Divider(
        color: Theme.of(context).dividerColor,
        height: 1,
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
