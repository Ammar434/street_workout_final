import 'package:flutter/material.dart';
import "../../../../common_libs.dart";
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/workout.dart';
import '../../../../provider/workout_provider.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/rounded_button.dart';
import '../select_training/components/workout_category_list_builder.dart';
import 'components/color_picker_for_add_workout.dart';
import 'components/drop_down_button.dart';
import 'components/text_field_for_add_workout.dart';
import 'components/workout_type_selector.dart';

List<String> workoutType = [
  "Weight and Reps",
  "Weight and Distance",
  "Weight and Time",
  "Reps and Distance",
  "Distance and Time",
];

class AddWorkout extends StatefulWidget {
  const AddWorkout({Key? key, required this.workoutCategory, required this.workoutName, required this.isEditing, required this.workoutId}) : super(key: key);
  static String name = "AddWorkout";
  final String workoutCategory;
  final String workoutName;
  final String workoutId;
  final bool isEditing;

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  TextEditingController textEditingController = TextEditingController();
  String? dropdownValue = categoryNames.first;
  String currentOptions = workoutType[0];
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.workoutName;
    dropdownValue = widget.workoutCategory;
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, "New exercice"),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Padding(
                padding: EdgeInsets.all(kPaddingValue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFieldForAddWorkout(
                      textEditingControllerParcName: textEditingController,
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    ),
                    DropdownButtonWorkout(
                      dropdownValue: dropdownValue,
                      function: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    ),
                    WorkoutTypeSelector(
                      currentOptions: currentOptions,
                      function: (value) {
                        setState(() {
                          currentOptions = value.toString();
                        });
                      },
                    ),
                    ColorPickerForAddWorkout(
                      pickerColor: pickerColor,
                      function: changeColor,
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    ),
                    RoundedButton(
                      onTap: () {
                        Workout w = Workout(
                          id: const Uuid().v1(),
                          name: textEditingController.text,
                          type: "",
                          color: pickerColor,
                          image: "",
                          category: dropdownValue!,
                        );
                        if (widget.isEditing) {
                          workoutProvider.removeWorkoutFromStorage(widget.workoutId);
                        }
                        workoutProvider.addWorkoutToStorage(w);
                        Navigator.pop(context);
                      },
                      text: "Add exercice",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
