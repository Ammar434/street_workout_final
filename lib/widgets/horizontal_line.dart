import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSmallPaddingValue * 2),
      child: const Divider(
        color: tertiaryColor,
        height: 1,
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
