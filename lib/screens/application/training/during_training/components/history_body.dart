import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/sets.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/provider/training_provider.dart';
import 'package:street_workout_final/services/dates_services.dart';
import 'package:street_workout_final/services/training/training_services.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

import '../../../../../models/training.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key? key,
    required this.workout,
  }) : super(key: key);
  final Workout workout;
  List<Sets> buildListSets(Training training) {
    List<Sets> list = [];

    for (Workout w in training.listWorkout) {
      if (w.id == workout.id) {
        list.addAll(w.listSets);
      }
    }
    // list.sort(((a, b) => a.id.compareTo(b.id)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    TrainingServices trainingServices = TrainingServices();
    List<Training> trainingList = Provider.of<TrainingProvider>(context).getListTrainingContainingACertainWorkout(workout.id);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingList.length,
      itemBuilder: (context, index) {
        String dayName = getDayCompleteNameString(trainingList[index].dateTime.weekday).toUpperCase();
        String month = getMonth(trainingList[index].dateTime.month).toUpperCase();
        String date = "   $dayName $month ${trainingList[index].dateTime.day}";
        List<Sets> listSets = buildListSets(trainingList[index]);
        int bestIndex = trainingServices.indexOfBestSet(listSets);
        return Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date),
              const HorizontalLine(),
              ...List.generate(
                listSets.length,
                (index2) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    index2 == bestIndex ? SizedBox(width: kPaddingValue, child: const FaIcon(FontAwesomeIcons.trophy)) : SizedBox(width: kPaddingValue),
                    SizedBox(
                      width: kPaddingValue * 5,
                      child: Text(
                        "${listSets[index2].weight} kgs",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: kPaddingValue * 5,
                      child: Text(
                        "${listSets[index2].numberOfRep} reps",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
