import 'package:street_workout_final/models/sets.dart';

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
}
