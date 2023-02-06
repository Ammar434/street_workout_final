import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import 'components/search_field_widget_for_trainning.dart';
import 'components/workout_category_list_builder.dart';

class SelectTrainningScreen extends StatelessWidget {
  const SelectTrainningScreen({Key? key}) : super(key: key);
  static String name = "SelectTrainningScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: SingleChildScrollView(
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
      ),
    );
  }
}
