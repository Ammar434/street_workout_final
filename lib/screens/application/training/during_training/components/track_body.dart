import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/dynamic_list_training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/provider/training_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';

import '../during_training_screen.dart';

// List<Sets> listSet = [];

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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late final TrainingProvider trainingProvider;
  final Duration duration = const Duration(milliseconds: 500);
  late DynamicListTraining dynamicListTraining;

  void initialiseTrainingAndWorkout() {
    trainingProvider = Provider.of<TrainingProvider>(context, listen: false);
    dynamicListTraining = DynamicListTraining(trainingProvider.listTrainingFromProvider);
    trainingProvider.initTraining();
    trainingProvider.initWorkout(widget.workout);

    if (listItem.isEmpty) {
      createExpansionPanel();
    }
  }

  void createExpansionPanel() {
    final TextEditingController textEditingController1 = TextEditingController(text: "2.5");
    final TextEditingController textEditingController2 = TextEditingController(text: "1");

    listTextEdittingController.add(textEditingController1);
    listTextEdittingController.add(textEditingController2);

    String setId = const Uuid().v1();
    listItem.add(setId);
    listIsExpanded.add(true);
    listOfUniqueKey.add(UniqueKey());
    if (listItem.length > 1) {
      animatedListKey.currentState!.insertItem(listItem.length - 1, duration: duration);
    }
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
    //Delete from the list of set
    String idToFInd = listItem[index].toString();
    trainingProvider.removeSetToWorkout(widget.workout.id, idToFInd);

    listTextEdittingController[index].dispose();
    listTextEdittingController[index + 1].dispose();

    //List of two text editing controloer because the are join two by two
    listTextEdittingController.removeAt(index);
    listTextEdittingController.removeAt(index);
    listIsExpanded.removeAt(index);

    listOfUniqueKey.removeAt(index);

    listItem.removeAt(index);
  }

  void expandTile(int index) async {
    String idToFInd = listItem[index].toString();
    trainingProvider.removeSetToWorkout(widget.workout.id, idToFInd);

    setState(
      () {
        listIsExpanded[index] = true;
        listOfUniqueKey[index] = UniqueKey();
      },
    );
  }

  void shrinkTile(int index) {
    //Check if sets already exist
    double weight = double.parse(listTextEdittingController[index * 2].text);
    int numberOfRep = int.parse(listTextEdittingController[index * 2 + 1].text);
    if (weight == 0 || numberOfRep == 0) {
      customShowSnackBar(
        globalKey: scaffoldKey,
        title: 'Error',
        content: "Never do 0 rep 👻",
        contentType: ContentType.failure,
      );
      return;
    }
    saveWorkout(index, weight, numberOfRep);
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

  void saveWorkout(int index, double weight, int numberOfRep) {
    trainingProvider.addSetToWorkout(widget.workout.id, listItem[index], weight, numberOfRep);
  }

  @override
  void initState() {
    initialiseTrainingAndWorkout();
    super.initState();
  }

  @override
  void dispose() {
    trainingProvider.disposeWorkout(widget.workout);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        child: AnimatedList(
          shrinkWrap: true,
          key: animatedListKey,
          initialItemCount: listItem.length,
          itemBuilder: (context, index, animation) {
            return buildSlide(animation, index);
          },
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
          child: buildExpansionTile(index),
        ),
      ),
    );
  }

  ExpansionTile buildExpansionTile(int index) {
    return ExpansionTile(
      key: listOfUniqueKey[index],
      initiallyExpanded: listIsExpanded[index],
      onExpansionChanged: (bool isExpand) => onCheckButtonTap(index),
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
                "${listTextEdittingController[index * 2].text} kgs",
              ),
              Text(
                "${listTextEdittingController[index * 2 + 1].text} reps",
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
                    double value = double.parse(listTextEdittingController[index * 2].text);
                    value = value - 2.5;

                    if (value < 0) {
                      value = 0;
                    }
                    listTextEdittingController[index * 2].text = value.toString();
                  },
                  icon: const FaIcon(FontAwesomeIcons.minus),
                ),
                SizedBox(
                  width: 100.sp,
                  child: TextField(
                    controller: listTextEdittingController[index * 2],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    double value = double.parse(listTextEdittingController[index * 2].text);
                    value = value + 2.5;

                    listTextEdittingController[index * 2].text = value.toString();
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
                    double value = double.parse(listTextEdittingController[index * 2 + 1].text);
                    value = value - 1;
                    if (value < 0) {
                      value = 0;
                    }
                    listTextEdittingController[index * 2 + 1].text = (value.toInt()).toString();
                  },
                  icon: const FaIcon(FontAwesomeIcons.minus),
                ),
                SizedBox(
                  width: 100.sp,
                  child: TextField(
                    controller: listTextEdittingController[index * 2 + 1],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    double value = double.parse(listTextEdittingController[index * 2 + 1].text);
                    value = value + 1;
                    if (value < 0) {
                      value = 0;
                    }
                    listTextEdittingController[index * 2 + 1].text = (value.toInt()).toString();
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
    );
  }
}
