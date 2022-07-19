import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/parc_info/components/tab_view/parc_info_photos_tab.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class ParcInfoTabDisplay extends StatefulWidget {
  const ParcInfoTabDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<ParcInfoTabDisplay> createState() => _ParcInfoTabDisplayState();
}

class _ParcInfoTabDisplayState extends State<ParcInfoTabDisplay>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const Tab(text: 'Photos'),
    const Tab(text: 'Athletes'),
    const Tab(text: "Comments"),
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
    _tabController = TabController(length: 3, vsync: this);
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
            const ParcInfoPhotosTab(),
            Column(
              children: List.generate(totalAthlete, (index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(kSmallPaddingValue),
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
                      const SizedBox(
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
            Column(
              children: List.generate(
                20,
                (index) => Padding(
                  padding: const EdgeInsets.all(kSmallPaddingValue),
                  child: ListTile(
                    tileColor: tertiaryColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusValue),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(Faker.instance.image.image()),
                      radius: 22,
                    ),
                    title: Text(
                      Faker.instance.name.firstName(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(Faker.instance.datatype.string()),
                  ),
                ),
              ).toList(),
            ),
          ][_tabIndex],
        ),
      ],
    );
  }
}
