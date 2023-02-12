import 'dart:math';

import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../select_exercice/select_exercice_screen.dart';

List<String> categoryNames = [
  "Abs",
  "Back",
  "Biceps",
  "Cardio",
  "Chest",
  "Legs",
  "Shoulders",
  "Triceps",
];

class WorkoutCategoryListBuilder extends StatelessWidget {
  const WorkoutCategoryListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categoryNames.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectExerciceScreen(
                  workoutCategory: categoryNames[index],
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  SizedBox(
                    width: kPaddingValue,
                  ),
                  Text(
                    categoryNames[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: kDefaultIconAppBarSize,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      separatorBuilder: (context, index) => const HorizontalLine(),
    );
  }
}
