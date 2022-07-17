import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/profile_screen/components/top_part_profile_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'components/staggered_grid_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String name = "ProfileScreen";

  @override
  Widget build(BuildContext context) {
    int userContribution = 124;
    int userTrainingPoint = 124;
    int userEvaluation = 23;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
            actions: const [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: kPaddingValue),
                  child: FaIcon(
                    FontAwesomeIcons.shareNodes,
                    size: kDefaultIconAppBar,
                  ),
                ),
              )
            ],
            expandedHeight: 300,
            // pinned: true,
            stretch: true,
            onStretchTrigger: () async {
              debugPrint("Load more data");
            },

            flexibleSpace: TopPartProfileScreen(
              userContribution: userContribution,
              userTrainingPoint: userTrainingPoint,
              userEvaluation: userEvaluation,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: kPaddingValue),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return StaggeredGridImage(
                  index: index,
                  height: (index % 5 + 1) * 100,
                );
              },
              childCount: 120,
            ),
          ),
        ],
      ),
    );
  }
}
