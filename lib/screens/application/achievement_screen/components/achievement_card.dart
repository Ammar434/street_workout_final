import 'dart:math';

import 'package:flutter/material.dart';

import 'package:street_workout_final/utils/constants.dart';
import 'achievement_card_top.dart';
import 'achievement_logo_widget.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    Key? key,
    required this.title,
    required this.progressionLvl,
  }) : super(key: key);
  final String title;
  final double progressionLvl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPaddingValue),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff000000),
                  Color(0xff434343),
                  // Color(0xff2C5364),
                ],
              ),
              borderRadius: BorderRadius.circular(
                kRadiusValue,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AchievementCardTop(
                    title: title,
                    progressionLvl: progressionLvl,
                  ),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  Expanded(
                    // width: 150,
                    child: ListView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return AchievementLogoWidget(
                          isAchieve: Random().nextBool(),
                          image: "assets/images/achievements/asset_${Random().nextInt(30)}.png",
                        );
                      },
                    ),
                  ),
                  //   AchievementLogoWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
