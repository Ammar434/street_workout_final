import 'package:flutter/foundation.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/models/workout.dart';
import 'package:street_workout_final/services/dates_services.dart';

import '../models/sets.dart';

class TrainingProvider with ChangeNotifier {
  DateTime _daySelected = DateTime.now();

  DateTime get daySelected => _daySelected;

  void changeDaySelected(DateTime newDay) {
    _daySelected = newDay;
    debugPrint("day $_daySelected");
    notifyListeners();
  }

  final List<Training> _listTraining = [];

  List<Training> get listTrainingFromProvider => _listTraining;

  Training? getTrainingOfTheDay() {
    for (Training t in _listTraining) {
      if (isSameDay(t.dateTime, daySelected)) {
        notifyListeners();
        return t;
      }
    }
    notifyListeners();
    return null;
  }

  void createTraining() {
    Training t = Training(
      dateTime: _daySelected,
      listWorkout: [],
    );
    addTraining(t);
    notifyListeners();
  }

  void addTraining(Training training) {
    _listTraining.add(training);
    notifyListeners();
  }

  void initTraining() {
    Training? training = getTrainingOfTheDay();
    if (training == null) {
      createTraining();
    }
    notifyListeners();
  }

  void initWorkout(Workout workout) {
    Training? training = getTrainingOfTheDay();
    bool workoutExist = false;
    for (Workout w in training!.listWorkout) {
      if (w.id == workout.id) {
        workoutExist = true;
      }
    }
    if (!workoutExist) {
      training.listWorkout.add(workout.clone());
    }
    notifyListeners();
  }

  void disposeWorkout(Workout workout) {
    Training? training = getTrainingOfTheDay();

    for (Workout w in training!.listWorkout) {
      if (w.id == workout.id && w.listSets.isEmpty) {
        training.listWorkout.remove(w);
      }
    }

    notifyListeners();
  }

  void addSetToWorkout(String workoutId, String setId, double weight, int numberOfRep) {
    Training? t = getTrainingOfTheDay();

    for (Workout w in t!.listWorkout) {
      if (w.id == workoutId) {
        Sets s = Sets(
          numberOfRep: numberOfRep,
          weight: weight,
          distance: 0,
          duration: Duration.zero,
          id: setId,
        );
        w.listSets.add(s);
        break;
      }
    }

    notifyListeners();
  }

  void removeSetToWorkout(String workoutId, String setId) {
    Training? t = getTrainingOfTheDay();
    Workout? workout;

    for (Workout w in t!.listWorkout) {
      if (w.id == workoutId) {
        workout = w;
        break;
      }
    }

    for (int i = 0; i < workout!.listSets.length; i++) {
      if (workout.listSets[i].id == setId) {
        workout.listSets.removeAt(i);
        notifyListeners();
        return;
      }
    }
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
