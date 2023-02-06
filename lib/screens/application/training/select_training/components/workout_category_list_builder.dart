import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../widgets/horizontal_line.dart';
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
    // WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    // int length = workoutProvider.listWorkoutFromProvider.length;
    return ListView.separated(
      itemCount: categoryNames.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectExerciceScreen(workoutCategory: categoryNames[index])),
              ),
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
                    style: kTextStyleImportance4,
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
