import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class ParcInfoTabDisplay extends StatelessWidget {
  const ParcInfoTabDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalAthlete = 23;
    return DefaultTabController(
      length: 3, // length of tabs
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TabBar(
            indicatorColor: primaryColor,
            tabs: [
              Tab(text: "Champ's"),
              Tab(text: 'Photos'),
              Tab(text: 'Athletes'),
            ],
          ),
          Container(
            height: 500, //height of TabBarView
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: TabBarView(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    final faker = Faker.instance;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              faker.image.image(),
                            ),
                          ),
                          const SizedBox(
                            width: kPaddingValue,
                          ),
                          Text(
                            faker.name.fullName(),
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    );
                  },
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Image(
                      image: NetworkImage(Faker.instance.image.image()),
                    );
                  },
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: kPaddingValue,
                    ),
                    Text(
                      "Total athlete who train in this park $totalAthlete",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: secondaryColor,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: totalAthlete,
                        itemBuilder: (context, index) {
                          Faker faker = Faker.instance;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    faker.image.image(),
                                  ),
                                ),
                                const SizedBox(
                                  width: kPaddingValue,
                                ),
                                Text(
                                  faker.name.fullName(),
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
