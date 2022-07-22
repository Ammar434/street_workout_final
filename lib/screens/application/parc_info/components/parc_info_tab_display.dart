import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/services/firestore_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'package:street_workout_final/widgets/staggered_grid_view.dart';

class ParcInfoTabDisplay extends StatefulWidget {
  const ParcInfoTabDisplay({
    Key? key,
    required this.parcId,
  }) : super(key: key);
  final Parc parcId;
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
  bool isLoading = false;
  List<String> listUrl = [];
  List<CustomUser> listUserWhoTrainInThisParc = [];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    loadData();
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    listUrl = await FirestoreMethods().getAllImageOfParc(widget.parcId.parcId);
    for (String s in widget.parcId.athletesWhoTrainInThisParc) {
      CustomUser user = await FirestoreMethods().findUserByUid(s);
      listUserWhoTrainInThisParc.add(user);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: myTabs,
                indicatorColor: primaryColor,
              ),
              Container(
                child: [
                  StaggeredGridView(
                    listUrlImage: listUrl,
                  ),
                  Column(
                    children: List.generate(
                        listUserWhoTrainInThisParc.length + 1, (index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: kPaddingValue),
                          child: Text(
                            listUserWhoTrainInThisParc.isEmpty
                                ? "No user train in this parc for the moment"
                                : "Total athlete who train in this park ${listUserWhoTrainInThisParc.length}",
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
                                listUserWhoTrainInThisParc[index - 1]
                                    .profileImage,
                              ),
                            ),
                            const SizedBox(
                              width: kPaddingValue,
                            ),
                            Text(
                              listUserWhoTrainInThisParc[index - 1].userName,
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
