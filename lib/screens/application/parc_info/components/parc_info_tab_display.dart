import 'package:flutter/material.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
import '../../../../widgets/staggered_grid_view.dart';
import 'build_athlete_tab.dart';

class ParcInfoTabDisplay extends StatelessWidget {
  const ParcInfoTabDisplay({
    Key? key,
    required this.parc,
    required this.tabController,
    required this.index,
    required this.listCustomUser,
    required this.listUrlImage,
  }) : super(key: key);
  final Parc parc;
  final TabController tabController;
  final int index;
  final List<CustomUser> listCustomUser;
  final List<String> listUrlImage;

  @override
  Widget build(BuildContext context) {
    final List<Widget> myTabs = [
      const Tab(text: 'Photos'),
      const Tab(text: 'Athletes'),
      //  Tab(text: "Comments"),
    ];
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: myTabs,
        ),
        Container(
          child: [
            StaggeredGridView(listUrlImage: listUrlImage),
            BuildAthleteTab(listCustomUser: listCustomUser),
            // Container(),
          ][index],
        )
      ],
    );
  }
}
