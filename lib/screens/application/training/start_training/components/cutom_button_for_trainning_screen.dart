import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../utils/constants.dart';

class CustomButtonForTrainingScreen extends StatelessWidget {
  const CustomButtonForTrainingScreen({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusValue)),
      radius: kRadiusValue,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FaIcon(iconData),
            Text(text),
          ],
        ),
      ),
    );
  }
}
