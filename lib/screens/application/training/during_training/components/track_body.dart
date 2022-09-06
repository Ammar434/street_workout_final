import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/datas/training/training_data.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/services/dates_services.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

List listItem = [];
List<bool> listIsExpanded = [];
List<UniqueKey> listOfUniqueKey = [];
List<TextEditingController> listTextEdittingController = [];

class TrackBody extends StatefulWidget {
  const TrackBody({
    Key? key,
    required this.workout,
  }) : super(key: key);
  final Workout workout;
  @override
  State<TrackBody> createState() => _TrackBodyState();
}

class _TrackBodyState extends State<TrackBody> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
  final Duration duration = const Duration(milliseconds: 500);
  final DateTime dateTime = DateTime.now();
  late Training training;
  late Workout workout;
  void removeExpansionPanel(int index) {
    animatedListKey.currentState!.removeItem(index, (_, animation) {
      return SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).chain(
            CurveTween(curve: Curves.easeInOutCubic),
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusValue),
          ),
          elevation: 10,
          color: Colors.red,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FaIcon(FontAwesomeIcons.trash),
                Text("Deleting", style: kTextStyleImportance4),
              ],
            ),
          ),
        ),
      );
    }, duration: duration);

    listTextEdittingController[index].dispose();
    listTextEdittingController[index + 1].dispose();

    //List of two text editing controloer because the are join two by two
    listTextEdittingController.removeAt(index);
    listTextEdittingController.removeAt(index);
    listIsExpanded.removeAt(index);
    listOfUniqueKey.removeAt(index);

    listItem.removeAt(index);
  }

  void createExpansionPanel() {
    for (int i = 0; i < listIsExpanded.length; i++) {
      listIsExpanded[i] = false;
    }

    final TextEditingController textEditingController1 = TextEditingController();
    final TextEditingController textEditingController2 = TextEditingController();
    textEditingController1.text = "2.5";
    textEditingController2.text = "1";
    listTextEdittingController.add(textEditingController1);
    listTextEdittingController.add(textEditingController2);

    listItem.add("Item ${listItem.length + 1}");
    listIsExpanded.add(true);
    listOfUniqueKey.add(UniqueKey());
    animatedListKey.currentState!.insertItem(listItem.length - 1, duration: duration);
  }

  void expandTile(int index) {
    setState(
      () {
        listIsExpanded[index] = true;
        listOfUniqueKey[index] = UniqueKey();
      },
    );
  }

  void shrinkTile(int index) {
    setState(
      () {
        listIsExpanded[index] = false;
        listOfUniqueKey[index] = UniqueKey();
      },
    );
  }

  void onCheckButtonTap(int index) {
    if (listIsExpanded[index]) {
      shrinkTile(index);
    } else {
      expandTile(index);
    }
  }

  void saveWorkout() {
    bool isTrainingExistForTheDay = false;
    bool isWorkoutExistForTheDay = false;

    //On parcours pour voir si ub training existe pour la journee
    for (Training t in listTraining) {
      if (isSameDay(t.dateTime, dateTime)) {
        isTrainingExistForTheDay = true;
        training = t;
        break;
      }
    }

    if (!isTrainingExistForTheDay) {
      training = Training(
        dateTime: dateTime,
        listWorkout: [],
      );
    }

    for (Workout w in training.listWorkout) {
      if (w.id == widget.workout.id) {
        isWorkoutExistForTheDay = true;
        workout = w;
        break;
      }
    }

    if (!isWorkoutExistForTheDay) {
      workout = widget.workout.clone();
    }

    for (int i = 0; i < listIsExpanded.length; i++) {
      listIsExpanded[i] = false;
    }
    setState(() {});

    for (int i = 0; i < listTextEdittingController.length; i = i + 2) {
      double weight = double.parse(listTextEdittingController[i].text);
      int numberOfRep = int.parse(listTextEdittingController[i + 1].text);

      workout.addSetOfRep(weight, numberOfRep);
    }

    if (!isWorkoutExistForTheDay) {
      training.addWorkout(workout);
    }
    if (!isTrainingExistForTheDay) {
      listTraining.add(training);
    }
  }

  @override
  void dispose() {
    saveWorkout();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          createExpansionPanel();
        },
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: iconColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: animatedListKey,
                initialItemCount: listItem.length,
                itemBuilder: (context, index, animation) {
                  return buildSlide(animation, index);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: kPaddingValue * 5),
              child: RoundedButton(
                onTap: () {
                  saveWorkout();
                },
                text: "Save",
              ),
            )
          ],
        ),
      ),
    );
  }

  SlideTransition buildSlide(Animation<double> animation, int index) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).chain(
          CurveTween(
            curve: Curves.easeInOutCubic,
          ),
        ),
      ),
      key: UniqueKey(),
      child: Padding(
        padding: EdgeInsets.only(bottom: kSmallPaddingValue),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusValue),
          ),
          color: listIsExpanded[index] ? tertiaryColor.withOpacity(0.1) : Colors.green,
          child: ExpansionTile(
            key: listOfUniqueKey[index],
            initiallyExpanded: listIsExpanded[index],
            onExpansionChanged: (bool isExpand) {
              setState(() {
                listIsExpanded[index] = isExpand;
              });
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => removeExpansionPanel(index),
              icon: const FaIcon(FontAwesomeIcons.trash),
            ),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => onCheckButtonTap(index),
              icon: listIsExpanded[index]
                  ? const FaIcon(FontAwesomeIcons.circle)
                  : const FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: iconColor,
                    ),
            ),
            title: listIsExpanded[index]
                ? Text("Set #${index + 1}")
                : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Text(
                      "${listTextEdittingController[index].text} kgs",
                    ),
                    Text(
                      "${listTextEdittingController[index + 1].text} reps",
                    ),
                  ]),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: kPaddingValue),
                    child: const Text("Weight (kgs)"),
                  ),
                  const HorizontalLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          double value = double.parse(listTextEdittingController[index].text);
                          value = value - 2.5;
                          if (value < 0) {
                            value = 0;
                          }
                          listTextEdittingController[index].text = value.toString();
                        },
                        icon: const FaIcon(FontAwesomeIcons.minus),
                      ),
                      SizedBox(
                        width: 100.sp,
                        child: TextField(
                          controller: listTextEdittingController[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          double value = double.parse(listTextEdittingController[index].text);
                          value = value + 2.5;
                          if (value < 0) {
                            value = 0;
                          }
                          listTextEdittingController[index].text = value.toString();
                        },
                        icon: const FaIcon(FontAwesomeIcons.plus),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: kPaddingValue),
                    child: const Text("Reps "),
                  ),
                  const HorizontalLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          double value = double.parse(listTextEdittingController[index + 1].text);
                          value = value - 2.5;
                          if (value < 0) {
                            value = 0;
                          }
                          listTextEdittingController[index + 1].text = (value.toInt()).toString();
                        },
                        icon: const FaIcon(FontAwesomeIcons.minus),
                      ),
                      SizedBox(
                        width: 100.sp,
                        child: TextField(
                          controller: listTextEdittingController[index + 1],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          double value = double.parse(listTextEdittingController[index + 1].text);
                          value = value + 1;
                          if (value < 0) {
                            value = 0;
                          }
                          listTextEdittingController[index + 1].text = (value.toInt()).toString();
                        },
                        icon: const FaIcon(FontAwesomeIcons.plus),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: kPaddingValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
