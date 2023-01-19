import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/constants.dart';

class ParcInfoListOfAthleteTab extends StatelessWidget {
  const ParcInfoListOfAthleteTab({
    Key? key,
    required this.totalAthlete,
  }) : super(key: key);

  final int totalAthlete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kPaddingValue,
        ),
        Padding(
          padding: EdgeInsets.all(kSmallPaddingValue),
          child: Text(
            "Total athlete who train in this park $totalAthlete",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: secondaryColor,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                    SizedBox(
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
    );
  }
}
