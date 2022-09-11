import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/datas/training/training_data.dart';
import 'package:street_workout_final/models/sets.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/provider/training_provider.dart';
import 'package:street_workout_final/services/dates_services.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:uuid/uuid.dart';

UniqueKey firstTile = UniqueKey();

List<String> listItem = [];
List<bool> listIsExpanded = [];
//To expand or shrink tile list of unique key
List<UniqueKey> listOfUniqueKey = [];
List<TextEditingController> listTextEdittingController = [];

List<Sets> listSet = [];

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

  void printListSet() {
    print(listSet.length);
    for (Sets s in listSet) {
      print("1--------------------------------------------");
      print(s.id);
      print("${s.numberOfRep} ${s.weight}");
      print("2--------------------------------------------");
    }
  }

  void initialiseTrainingAndWorkout() {
    TrainingProvider trainingProvider = Provider.of<TrainingProvider>(context, listen: false);
    bool isTrainingExistForTheDay = false;
    bool isWorkoutExistForTheDay = false;

    //On parcours pour voir si un training existe pour la journee
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
    //On parcours pour voir si un workout existe pour la journee

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
    if (!isWorkoutExistForTheDay) {
      training.addWorkout(workout);
    }
    if (!isTrainingExistForTheDay) {
      trainingProvider.addTraining(training);
    }
  }

  void createExpansionPanel() {
    printListSet();
    final TextEditingController textEditingController1 = TextEditingController(text: "2.5");
    final TextEditingController textEditingController2 = TextEditingController(text: "1");

    listTextEdittingController.add(textEditingController1);
    listTextEdittingController.add(textEditingController2);

    String setId = const Uuid().v1();
    listItem.add(setId);
    listIsExpanded.add(true);
    listOfUniqueKey.add(UniqueKey());
    animatedListKey.currentState!.insertItem(listItem.length - 1, duration: duration);
  }

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

    listSet.removeWhere((element) => element.id == listOfUniqueKey[index].toString());
    listOfUniqueKey.removeAt(index);

    listItem.removeAt(index);
  }

  void expandTile(int index) {
    String idToFInd = listItem[index].toString();

    for (int i = 0; i < listSet.length; i++) {
      if (listSet[i].id == idToFInd) {
        print("removeeeeee");
        listSet.removeAt(i);
        break;
      }
    }

    setState(
      () {
        listIsExpanded[index] = true;
        listOfUniqueKey[index] = UniqueKey();
      },
    );
  }

  void shrinkTile(int index) {
    saveWorkout(index);
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

  void saveWorkout(int index) {
    //Check if sets already exist

    for (Sets s in listSet) {
      if (s.id == listItem[index]) {
        print("nfdgfgfdgdg");
        double weight = double.parse(listTextEdittingController[index].text);
        int numberOfRep = int.parse(listTextEdittingController[index + 1].text);
        s.weight = weight;
        s.numberOfRep = numberOfRep;
        return;
      }
    }

    double weight = double.parse(listTextEdittingController[index].text);
    int numberOfRep = int.parse(listTextEdittingController[index + 1].text);
    Sets s = Sets(numberOfRep: numberOfRep, weight: weight, distance: 0, duration: Duration.zero, id: listItem[index]);
    listSet.add(s);
  }

  @override
  void initState() {
    initialiseTrainingAndWorkout();
    super.initState();
  }

  @override
  void dispose() {
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(kPaddingValue),
            child: AnimatedList(
              shrinkWrap: true,
              key: animatedListKey,
              initialItemCount: listItem.length,
              itemBuilder: (context, index, animation) {
                return buildSlide(animation, index);
              },
            ),
          ),
          RoundedButton(onTap: () => printListSet(), text: "text"),
          RoundedButton(
              onTap: () {
                for (int i = 0; i < listSet.length; i++) {
                  print("set ${listSet[i].id} id ${listItem[i]}");
                }
              },
              text: "text2")
        ],
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
              isExpand ? expandTile(index) : shrinkTile(index);
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
