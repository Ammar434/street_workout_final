import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/sets.dart';
import '../models/training.dart';
import '../services/dates_services.dart';

const String TRAINING_LIST = "trainings";

class TrainingProvider with ChangeNotifier {
  List<Training> _listTraining = [];
  List<Training> get listTrainingFromProvider => _listTraining;

  DateTime _daySelected = DateTime.now();

  DateTime get daySelected => _daySelected;

  void changeDaySelected(DateTime newDay) {
    _daySelected = newDay;
    // debugPrint("day $_daySelected");
    notifyListeners();
  }

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

  TrainingProvider() {
    syncDataWithProvider();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(TRAINING_LIST);

    if (result != null) {
      _listTraining = result.map((f) => Training.fromJson(json.decode(f))).toList();
    }

    notifyListeners();
  }

  void initTraining(String workoutId) {
    Training? training = getTrainingOfTheDay();
    if (training == null) {
      createTraining(workoutId);
    }
    notifyListeners();
  }

  void createTraining(String id) {
    Training t = Training(
      dateTime: _daySelected,
      // listWorkoutId: [],
      mapOfSet: {id: []},
    );
    addTrainingToStorage(t);
    notifyListeners();
  }

  List<Sets> getCurrentWorkoutSets(String workoutId) {
    Training? training = getTrainingOfTheDay();

    // if (training != null) {
    print("Training not null");
    print(training!.mapOfSet);

    List<Sets> l = training.mapOfSet[workoutId]!;

    notifyListeners();
    return l;
    // }
    // return null;
  }

  void addTrainingToStorage(Training training) {
    _listTraining.add(training);
    updateSharedPrefrences();
    notifyListeners();
  }

  Future updateSharedPrefrences() async {
    List<String> jsonToSave = [];

    for (Training w in _listTraining) {
      String t = (jsonEncode(w.toJson()));
      jsonToSave.add(t);
      // print(t);
      // Workout test = Workout.fromJson(jsonDecode(t));
      // print(test.id);
    }

    // print(jsonToSave);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(TRAINING_LIST, jsonToSave);
  }

  // void initWorkout(Workout workout) {
  //   Training? training = getTrainingOfTheDay();
  //   bool workoutExist = false;
  //   for (Workout w in training!.listWorkout) {
  //     if (w.id == workout.id) {
  //       workoutExist = true;
  //     }
  //   }
  //   if (!workoutExist) {
  //     training.listWorkout.add(workout.clone());
  //   }
  //   notifyListeners();
  // }

  // void disposeWorkout(Workout workout) {
  //   Training? training = getTrainingOfTheDay();

  //   for (Workout w in training!.listWorkout) {
  //     if (w.id == workout.id && w.listSets.isEmpty) {
  //       training.listWorkout.remove(w);
  //     }
  //   }

  //   notifyListeners();
  // }

  void addSetToWorkout(String workoutId, String setId, double weight, int numberOfRep) {
    Training? t = getTrainingOfTheDay();
    Sets s = Sets(
      workoutId: workoutId,
      numberOfRep: numberOfRep,
      weight: weight,
      distance: 0,
      duration: Duration.zero,
      id: setId,
    );
    t!.mapOfSet.update(
      workoutId,
      (value) {
        List<Sets> l = value;
        l.add(s);
        return l;
      },
      ifAbsent: () => [s],
    );

    print("Addd");
    print(t.mapOfSet);
    notifyListeners();
  }

  void removeSetToWorkout(String workoutId, String setId) {
    Training? t = getTrainingOfTheDay();

    t!.mapOfSet.update(
      workoutId,
      (value) {
        List<Sets> l = value;
        l.removeWhere(
          (element) => element.id == setId,
        );
        return l;
      },
    );
    print("Remove");
    print(t.mapOfSet);

    // for (int i = 0; i < workout!.listSets.length; i++) {
    //   if (workout.listSets[i].id == setId) {
    //     workout.listSets.removeAt(i);
    //     notifyListeners();
    //     return;
    //   }
    // }
    notifyListeners();
  }

  List<Training> getListTrainingContainingACertainWorkout(String workoutId) {
    List<Training> lt = [];
    for (Training t in _listTraining) {
      // print("Ammar");
      if (t.mapOfSet.containsKey(workoutId)) {
        lt.add(t);
      }

      // for (Workout w in t.listWorkout) {
      //   if (w.id == workoutId) {
      //     lt.add(t);
      //   }
      // }
    }
    return lt;
  }
}
