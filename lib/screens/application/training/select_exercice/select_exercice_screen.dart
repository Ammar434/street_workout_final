import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/workout.dart';
import '../../../../provider/workout_provider.dart';
import '../add_workout/add_workout.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_style.dart';
import '../../../../widgets/app_bar.dart';

import '../during_training/during_training_screen.dart';
import 'components/dropdown_dialog.dart';

class SelectExerciceScreen extends StatelessWidget {
  const SelectExerciceScreen({Key? key, required this.workoutCategory}) : super(key: key);
  static String name = "SelectExerciceScreen";
  final String workoutCategory;
  @override
  Widget build(BuildContext context) {
    final double cardSize = 80.sp;
    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    // workoutProvider.syncDataWithProvider();
    List<Workout> workoutList = workoutProvider.listWorkoutFromProvider
        .where(
          (Workout w) => (w.category == workoutCategory),
        )
        .toList();

    void onFloattingActionPress() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddWorkout(
            workoutCategory: workoutCategory,
            workoutName: "",
            isEditing: false,
            workoutId: '',
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, workoutCategory),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: onFloattingActionPress,
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: iconColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: GridView.builder(
            itemCount: workoutList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: kPaddingValue, mainAxisSpacing: kPaddingValue),
            itemBuilder: (context, index) {
              Offset offset = index.isEven ? Offset(-(cardSize + kSmallPaddingValue), 0) : Offset.zero;
              return GestureDetector(
                onTap: () {
                  // workoutProvider.updateSharedPrefrences();
                  // workoutProvider.syncDataWithProvider();
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
                          DropdownDialog(
                            offset: offset,
                            workoutProvider: workoutProvider,
                            workoutList: workoutList,
                            index: index,
                          ),
                          Center(
                            child: Card(
                              elevation: 10,
                              color: Colors.black.withOpacity(0.5),
                              child: SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    workoutList[index].name,
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