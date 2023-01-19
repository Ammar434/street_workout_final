import 'package:fl_chart/fl_chart.dart';
import 'package:street_workout_final/models/sets.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';

class TrainingServices {
  double brzyckiFormula(double weight, int nbRep) {
    return weight * (36 / (37 - nbRep));
  }

  double epleyFormula(double weight, int nbRep) {
    return weight * (1 + (1 / 30 * nbRep));
  }

  double lombardiFormula(double weight, int nbRep) {
    return weight * (nbRep * 0.1);
  }

  double connerFormula(double weight, int nbRep) {
    return weight * (1 + (1 / 40 * nbRep));
  }

  double average1RepMax(double weight, int nbRep) {
    double average = brzyckiFormula(weight, nbRep) + epleyFormula(weight, nbRep) + lombardiFormula(weight, nbRep) + connerFormula(weight, nbRep);
    average = average / 4;
    return average;
  }

  int indexOfBestSet(List<Sets> list) {
    double max = 0;
    double actualMax = 0;
    int bestIndex = 0;
    for (int i = 0; i < list.length; i++) {
      actualMax = average1RepMax(list[i].weight, list[i].numberOfRep);
      if (actualMax > max) {
        max = actualMax;
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  List<Sets> buildListSets(Training training, Workout workout) {
    List<Sets> list = [];

    for (Workout w in training.listWorkout) {
      if (w.id == workout.id) {
        list.addAll(w.listSets);
      }
    }
    return list;
  }

  List<FlSpot> buildListFlSpot(List<Training> listTraining, Workout workout) {
    List<FlSpot> listFlSpot = [];

    for (Training t in listTraining) {
      List<Sets> listSets = buildListSets(t, workout);
      int indexBestSet = indexOfBestSet(listSets);
      FlSpot flSpot = FlSpot(t.dateTime.day.toDouble(), listSets[indexBestSet].weight);
      listFlSpot.add(flSpot);
    }
    // print("listFl $listFlSpot");
    return listFlSpot;
  }
}
