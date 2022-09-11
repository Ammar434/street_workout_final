import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/provider/training_provider.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key? key,
    required this.workout,
  }) : super(key: key);
  final Workout workout;
  @override
  Widget build(BuildContext context) {
    List<Training> trainingList = Provider.of<TrainingProvider>(context).getListTrainingContainingACertainWorkout(workout.id);
    print("tr ${trainingList[0].listWorkout[0].listSets.length}");

    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingList.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
          child: Column(
            children: [
              Text(
                trainingList[index].dateTime.toString(),
              ),
              ...List.generate(
                trainingList[index].listWorkout.length,
                (index2) => Text(trainingList[index].listWorkout[index2].listSets.length.toString()),
              )
            ],
          ),
        );
      },
    );
  }
}
