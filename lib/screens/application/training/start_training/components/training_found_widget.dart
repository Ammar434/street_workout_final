import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/provider/training_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class TrainingFoundWidget extends StatelessWidget {
  const TrainingFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrainingProvider trainingProvider = Provider.of<TrainingProvider>(context);
    Training? trainingOfTheDay = trainingProvider.getTrainingOfTheDay();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingOfTheDay!.listWorkout.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusValue)),
            color: tertiaryColor.withOpacity(0.1),
            elevation: 10,
            child: Column(
              children: [
                Row(
                  children: [Text(trainingOfTheDay.listWorkout[index].name)],
                ),
                const HorizontalLine(),
                ...List.generate(
                  trainingOfTheDay.listWorkout[index].listSets.length,
                  ((index2) {
                    return Row(
                      children: [
                        Text("${index2 + 1} ."),
                        SizedBox(width: kPaddingValue),
                        Text("Weight ${trainingOfTheDay.listWorkout[index].listSets[index2].weight}"),
                        Text("Reps ${trainingOfTheDay.listWorkout[index].listSets[index2].numberOfRep}"),
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
