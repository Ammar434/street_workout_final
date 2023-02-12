import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../models/workout.dart';
import '../../../../../provider/workout_provider.dart';
import '../../../../../widgets/solid_circle_icon.dart';
import '../../add_workout/add_workout.dart';

class DropdownDialog extends StatelessWidget {
  const DropdownDialog({
    Key? key,
    required this.offset,
    required this.workoutProvider,
    required this.workoutList,
    required this.index,
  }) : super(key: key);

  final Offset offset;
  final WorkoutProvider workoutProvider;
  final List<Workout> workoutList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(kSmallPaddingValue),
        child: PopupMenuButton(
          elevation: 10,
          offset: offset,
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusValue),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await Future.delayed(Duration.zero);
                  navigator.push(
                    MaterialPageRoute(
                      builder: (_) => AddWorkout(
                        isEditing: true,
                        workoutCategory: workoutList[index].category,
                        workoutName: workoutList[index].name,
                        workoutId: workoutList[index].id,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.penToSquare,
                    ),
                    SizedBox(
                      width: kPaddingValue,
                    ),
                    Text(
                      "Edit",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  workoutProvider.removeWorkoutFromStorage(workoutList[index].id);
                },
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.trash,
                    ),
                    SizedBox(
                      width: kPaddingValue,
                    ),
                    Text(
                      "Delete",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ];
          },
          child: SolidCircleIcon(
            iconData: FontAwesomeIcons.ellipsisVertical,
            iconSize: kDefaultIconAppBarSize,
          ),
        ),
      ),
    );
  }
}
