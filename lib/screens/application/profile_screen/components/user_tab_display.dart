import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/staggered_grid_view.dart';

class UserTabDisplay extends StatefulWidget {
  const UserTabDisplay({
    Key? key,
    required this.listUrlImage,
  }) : super(key: key);
  final List<String> listUrlImage;

  @override
  State<UserTabDisplay> createState() => _UserTabDisplayState();
}

class _UserTabDisplayState extends State<UserTabDisplay> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const Tab(text: 'Photos'),
    const Tab(text: 'Rewards'),
    //   Tab(text: "Comments"),
  ];

  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalAthlete = 23;
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: myTabs,
          indicatorColor: primaryColor,
        ),
        Container(
          child: [
            StaggeredGridView(
              listUrlImage: widget.listUrlImage,
            ),
            Column(
              children: List.generate(totalAthlete, (index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.all(kSmallPaddingValue),
                    child: Text(
                      "Total athlete who train in this park $totalAthlete",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: secondaryColor,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          Faker.instance.image.image(),
                        ),
                      ),
                      SizedBox(
                        width: kPaddingValue,
                      ),
                      Text(
                        Faker.instance.name.fullName(),
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ][_tabIndex],
        ),
      ],
    );
  }
}
