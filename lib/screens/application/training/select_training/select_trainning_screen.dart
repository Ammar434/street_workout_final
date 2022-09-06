import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/training/select_training/components/search_field_widget_for_trainning.dart';
import 'package:street_workout_final/screens/application/training/select_training/components/workout_category_list_builder.dart';
import 'package:street_workout_final/utils/constants.dart';

class SelectTrainningScreen extends StatelessWidget {
  const SelectTrainningScreen({Key? key}) : super(key: key);
  static String name = "SelectTrainningScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            children: [
              const SearchFieldWidgetForTraining(),
              SizedBox(
                height: kPaddingValue,
              ),
              const WorkoutCategoryListBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
