import 'package:flutter/material.dart';
import "../../../common_libs.dart";
import '../../../widgets/app_bar.dart';

import '../../../models/rewards.dart';
import '../../../services/firestore_methods/rewards_firestore_methods.dart';

import '../../../widgets/loading_widget.dart';
import 'components/custom_tile_for_achievement.dart';

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
        appBar: buildAppBar(context, "Rewards"),
        body: FutureBuilder(
          future: RewardsFirestoreMethods().getRewardsSnapshot(),
          builder: (context, AsyncSnapshot<List<RewardsCategory>> list) {
            if (list.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
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
                    indicatorSize: TabBarIndicatorSize.tab,
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
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.data!.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: categoryHeight,
                              child: Text(
                                list.data![index].name,
                                style: Theme.of(context).textTheme.bodyLarge,
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
