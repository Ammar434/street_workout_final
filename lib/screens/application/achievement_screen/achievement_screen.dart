import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/screens/application/achievement_screen/components/custom_tile_for_achievement.dart';
import 'package:street_workout_final/services/firestore_methods/rewards_firestore_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import 'package:street_workout_final/utils/constants.dart';

double categoryHeight = 30;
double rewardsTileHeight = 80;

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key? key}) : super(key: key);
  static String name = "AchievementScreen";

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController scrollController;
  late List<RewardsCategory> listRewardCategory;
  double offsetFrom = 0.0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScrollListener);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.removeListener(onScrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void onScrollListener() {
    for (int i = 0; i < listRewardCategory.length; i++) {
      final category = listRewardCategory[i];

      if (scrollController.offset >= category.offsetFrom && scrollController.offset <= category.offsetTo && tabController.index != i) {
        tabController.animateTo(i);

        break;
      }
    }
  }

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
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: kDefaultIconAppBar,
              ),
            ),
          ),
          title: const Text("Achievements"),
        ),
        body: FutureBuilder(
          future: RewardsFirestoreMethods().getRewardsSnapshot(),
          builder: (context, AsyncSnapshot<List<RewardsCategory>> list) {
            if (list.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingWidget());
            }
            listRewardCategory = list.data!;

            tabController = TabController(
              length: list.data!.length,
              vsync: this,
            );

            return Padding(
              padding: EdgeInsets.all(kPaddingValue),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    indicatorColor: primaryColor,
                    indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                        kRadiusValue,
                      ),
                    ),
                    labelColor: Colors.white,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    onTap: (int index) {
                      scrollController.animateTo(
                        list.data!.elementAt(index).offsetFrom,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceOut,
                      );
                    },
                    tabs: List.generate(
                      list.data!.length,
                      (index) => Tab(
                        text: list.data![index].name,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.data!.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: categoryHeight,
                                child: Text(
                                  list.data![index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: kDefaultTitleSize * 0.75,
                                  ),
                                ),
                              ),
                            ),
                            ...List.generate(
                              list.data![index].rewardsList.length,
                              (index2) => CustomTileForAchievement(
                                rewards: list.data![index].rewardsList[index2],
                                height: rewardsTileHeight,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
