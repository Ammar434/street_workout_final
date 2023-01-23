import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../models/workout.dart';
import '../../../../../provider/workout_provider.dart';
import '../../add_workout/add_workout.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../widgets/solid_circle_icon.dart';

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
          color: backgroundColor,
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
                      style: kTextStyleImportance4,
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
                      style: kTextStyleImportance4,
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
