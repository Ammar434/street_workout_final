import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_workout_final/services/firestore_methods/workout_firestore_methods.dart';

import '../models/workout.dart';

String kWorkoutList = "workoutList";

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _listWorkouts = [];

  List<Workout> get listWorkoutFromProvider => _listWorkouts;

  WorkoutProvider() {
    syncDataWithProvider();
  }

  String addWorkoutToStorage(Workout workout) {
    String res = "Some error occured";
    try {
      _listWorkouts.add(workout);
      updateSharedPrefrences();
      res = "Success";
      notifyListeners();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  void removeWorkoutFromStorage(String workoutId) {
    _listWorkouts.removeWhere((w) => w.id == workoutId);

    updateSharedPrefrences();

    notifyListeners();
  }

  Future updateSharedPrefrences() async {
    List<String> jsonToSave = [];

    for (Workout w in _listWorkouts) {
      String t = (jsonEncode(w.toJson()));
      jsonToSave.add(t);
    }

    // print(jsonToSave);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(kWorkoutList, jsonToSave);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(kWorkoutList);

    if (result != null) {
      List<Workout> fromFirebase = await WorkoutFirestoreMethods().getWorkoutSnapshot();
      _listWorkouts = result.map((f) => Workout.fromJson(json.decode(f))).toList();

      for (Workout w in fromFirebase) {
        bool canBeAdded = true;
        for (Workout w2 in _listWorkouts) {
          if (w.id == w2.id) {
            canBeAdded = false;
          }
        }
        if (canBeAdded) {
          _listWorkouts.add(w);
        }
      }
    }

    notifyListeners();
  }

  Workout findWorkoutById(String id) {
    Workout w = _listWorkouts.singleWhere((element) => element.id == id);
    return w;
  }
}
