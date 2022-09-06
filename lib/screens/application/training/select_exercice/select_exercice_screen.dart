import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/screens/application/training/during_training/during_training_screen.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/solid_circle_icon.dart';

class SelectExerciceScreen extends StatelessWidget {
  const SelectExerciceScreen({Key? key, required this.workoutCategory}) : super(key: key);
  static String name = "SelectExerciceScreen";
  final WorkoutCategory workoutCategory;
  @override
  Widget build(BuildContext context) {
    final double cardSize = 80.sp;

    List<Workout> workoutList = workoutCategory.workoutList;
    List<PopupMenuEntry> menuList = [
      PopupMenuItem(
        onTap: () {},
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
        onTap: () {},
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
      PopupMenuItem(
        onTap: () {},
        child: Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.book,
            ),
            SizedBox(
              width: kPaddingValue,
            ),
            Text(
              "History",
              style: kTextStyleImportance4,
            ),
          ],
        ),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, workoutCategory.name),
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: GridView.builder(
            itemCount: workoutList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: kPaddingValue,
            ),
            itemBuilder: (context, index) {
              Offset offset = index.isEven ? Offset(-(cardSize + kSmallPaddingValue), 0) : Offset.zero;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DuringTrainingScreen(
                        workout: workoutList[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadiusValue),
                    color: workoutList[index].color,
                    image: DecorationImage(
                      image: NetworkImage(workoutList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 0.75,
                        sigmaX: 0.75,
                        tileMode: TileMode.decal,
                      ),
                      child: Stack(
                        children: [
                          Align(
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
                                  return menuList;
                                },
                                child: SolidCircleIcon(
                                  iconData: FontAwesomeIcons.ellipsisVertical,
                                  iconSize: kDefaultIconAppBarSize,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Card(
                              elevation: 10,
                              color: Colors.black.withOpacity(0.5),
                              child: SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'Some Text',
                                    style: kTextStyleImportance4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
