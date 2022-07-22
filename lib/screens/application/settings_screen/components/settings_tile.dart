import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.isArrow,
    required this.icon,
    required this.iconBackgroundColor,
    required this.text1,
    required this.text2,
    required this.press,
  }) : super(key: key);
  final IconData icon;
  final Color iconBackgroundColor;
  final String text1;
  final String text2;
  final bool isArrow;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingValue),
      child: GestureDetector(
        onTap: press,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconBackgroundColor,
              child: FaIcon(
                icon,
                color: iconColor,
              ),
            ),
            const SizedBox(
              width: kPaddingValue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: const TextStyle(
                    // color: primaryColor,
                    // fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Visibility(
                  visible: text2.isNotEmpty ? true : false,
                  child: Text(
                    text2,
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              isArrow ? Icons.arrow_forward_ios_rounded : null,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
