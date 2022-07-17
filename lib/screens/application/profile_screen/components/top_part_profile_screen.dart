import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_circle_user_profile_widget.dart';

import 'items_for_row_profile_screen.dart';

class TopPartProfileScreen extends StatelessWidget {
  const TopPartProfileScreen({
    Key? key,
    required this.userContribution,
    required this.userTrainingPoint,
    required this.userEvaluation,
  }) : super(key: key);

  final int userContribution;
  final int userTrainingPoint;
  final int userEvaluation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: tertiaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(kRadiusValue * 2),
              bottomRight: Radius.circular(kRadiusValue * 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: kPaddingValue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemForRowProfileScreen(
                  value: userContribution,
                  categorieName: "CONTRIBUTIONS",
                ),
                ItemForRowProfileScreen(
                  value: userTrainingPoint,
                  categorieName: "Points",
                ),
                ItemForRowProfileScreen(
                  value: userEvaluation,
                  categorieName: "Evaluation",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kPaddingValue * 5),
          child: Container(
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kRadiusValue * 2),
                  bottomRight: Radius.circular(kRadiusValue * 2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.max,
              children: [
                const RoundedCircleUserProfileWidget(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff40E0D0),
                      Color(0xffFF8C00),
                      Color(0xffFF0080),
                    ],
                  ),
                  radius: 60,
                ),
                const SizedBox(
                  height: kPaddingValue * 2,
                ),
                Text(
                  Faker.instance.name.fullName(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  Faker.instance.address.city(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: hintTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
