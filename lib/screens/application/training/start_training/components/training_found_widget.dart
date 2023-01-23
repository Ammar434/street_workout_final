import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../models/sets.dart';
import '../../../../../models/training.dart';
import '../../../../../models/workout.dart';
import '../../../../../provider/training_provider.dart';
import '../../../../../provider/workout_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/horizontal_line.dart';

class TrainingFoundWidget extends StatelessWidget {
  const TrainingFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrainingProvider trainingProvider = Provider.of<TrainingProvider>(context);
    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    Training? trainingOfTheDay = trainingProvider.getTrainingOfTheDay();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingOfTheDay!.mapOfSet.length,
      itemBuilder: (context, index) {
        String id = trainingOfTheDay.mapOfSet.keys.elementAt(index);
        Workout workout = workoutProvider.findWorkoutById(id);
        List<Sets> listSets = trainingOfTheDay.mapOfSet.values.elementAt(index);
        return SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusValue)),
            color: tertiaryColor.withOpacity(0.1),
            elevation: 10,
            // margin: EdgeInsets.all(kSmallPaddingValue * 5),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(workout.name),
                    ],
                  ),
                  const HorizontalLine(),
                  ...List.generate(
                    listSets.length,
                    ((index2) {
                      return Row(
                        children: [
                          Text("${index2 + 1} ."),
                          SizedBox(width: kPaddingValue),
                          Text("Weight ${listSets[index2].weight}"),
                          Text("Reps ${listSets[index2].numberOfRep}"),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
