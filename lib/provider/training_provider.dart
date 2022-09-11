import 'package:flutter/foundation.dart';
import 'package:street_workout_final/datas/training/training_data.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/services/dates_services.dart';

class TrainingProvider with ChangeNotifier {
  DateTime _daySelected = DateTime.now();
  final List<Training> _listTraining = listTraining;

  DateTime get daySelected => _daySelected;

  List<Training> get listTrainingFromProvider => _listTraining;

  void changeDaySelected(DateTime newDay) {
    _daySelected = newDay;
    debugPrint("day $_daySelected");
    notifyListeners();
  }

  void addTraining(Training t) {
    listTraining.add(t);
    notifyListeners();
  }

  Training? getTrainingOfTheDay() {
    for (Training t in listTraining) {
      if (isSameDay(t.dateTime, daySelected)) {
        notifyListeners();
        return t;
      }
    }
    notifyListeners();

    return null;
  }

  void addSetToWorkout(String workoutId, double weight, int numberOfRep) {
    Training? t = getTrainingOfTheDay();
    int i = 0;

    while (t!.listWorkout[i].id != workoutId && i <= t.listWorkout.length) {
      i++;
    }

    t.listWorkout[i].addSetOfRep(weight, numberOfRep, workoutId);

    print("length ${t.listWorkout[i].listSets.length}");
    notifyListeners();
  }

  List<Training> getListTrainingContainingACertainWorkout(String workoutId) {
    List<Training> lt = [];
    for (Training t in _listTraining) {
      for (Workout w in t.listWorkout) {
        if (w.id == workoutId) {
          lt.add(t);
        }
      }
    }
    return lt;
  }
}
