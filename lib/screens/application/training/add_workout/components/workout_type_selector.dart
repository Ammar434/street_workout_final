import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";

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
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const HorizontalLine(),
        ...List.generate(
          workoutType.length,
          (index) {
            return RadioListTile(
              title: Text(
                workoutType[index],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: workoutType[index],
              groupValue: currentOptions,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: function,
            );
          },
        )
      ],
    );
  }
}
