import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'components/achievement_card.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);
  static String name = "AchievementScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: kDefaultIconAppBar,
              ),
            ),
          ),
          title: const Text("Achievements"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: primaryColor,
                  indicator: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(
                      kRadiusValue,
                    ),
                  ),
                  labelColor: Colors.white,
                  // unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Strength"),
                    Tab(text: 'Social'),
                    Tab(text: 'Mental'),
                    Tab(text: 'Others'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          AchievementCard(
                            title: "Push Strength",
                            progressionLvl: Random().nextDouble(),
                          ),
                          AchievementCard(
                            title: "Push Strength",
                            progressionLvl: Random().nextDouble(),
                          ),
                        ],
                      ),
                      AchievementCard(
                        title: "Push Strength",
                        progressionLvl: Random().nextDouble(),
                      ),
                      AchievementCard(
                        title: "Push Strength",
                        progressionLvl: Random().nextDouble(),
                      ),
                      AchievementCard(
                        title: "Push Strength",
                        progressionLvl: Random().nextDouble(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
