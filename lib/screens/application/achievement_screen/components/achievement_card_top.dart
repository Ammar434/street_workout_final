import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class AchievementCardTop extends StatelessWidget {
  const AchievementCardTop({
    Key? key,
    required this.title,
    required this.progressionLvl,
  }) : super(key: key);

  final String title;
  final double progressionLvl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: kPaddingValue),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              // letterSpacing: 1.1,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(kRadiusValue),
            ),
            child: LinearProgressIndicator(
              backgroundColor: tertiaryColor,
              color: primaryColor,
              value: progressionLvl,
            ),
          ),
        ),
      ],
    );
  }
}
