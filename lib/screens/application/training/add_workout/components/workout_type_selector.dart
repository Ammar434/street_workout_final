import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../widgets/horizontal_line.dart';
import '../add_workout.dart';

class WorkoutTypeSelector extends StatelessWidget {
  const WorkoutTypeSelector({
    Key? key,
    required this.currentOptions,
    required this.function,
  }) : super(key: key);
  final String currentOptions;
  final Function(String?)? function;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: kPaddingValue,
          ),
          child: Text(
            "Type",
            style: kTextStyleImportance4,
          ),
        ),
        const HorizontalLine(),
        ...List.generate(
          workoutType.length,
          (index) {
            return RadioListTile(
              title: Text(workoutType[index]),
              value: workoutType[index],
              groupValue: currentOptions,
              activeColor: primaryColor,
              onChanged: function,
            );
          },
        )
      ],
    );
  }
}
