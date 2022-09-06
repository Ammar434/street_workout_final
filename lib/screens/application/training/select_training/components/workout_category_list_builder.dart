import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/screens/application/training/select_exercice/select_exercice_screen.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class WorkoutCategoryListBuilder extends StatelessWidget {
  const WorkoutCategoryListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int length = wokoutCategoryList.length;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: length * 2 + 1,
      itemBuilder: (context, index) {
        if (index.isEven || index == length) {
          return const HorizontalLine();
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectExerciceScreen(
                      workoutCategory: wokoutCategoryList[index ~/ 2],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: wokoutCategoryList[index ~/ 2].color,
                    ),
                    SizedBox(
                      width: kPaddingValue,
                    ),
                    Text(
                      wokoutCategoryList[index ~/ 2].name,
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
        );
      },
    );
  }
}
