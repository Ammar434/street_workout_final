import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/workout.dart';

const String kWorkoutList = "workoutList";

List<Workout> listWorkouts = [
  Workout(
    id: const Uuid().v1(),
    name: "Pull up",
    type: "WorkoutType.weightAndRep",
    color: const Color.fromARGB(15, 211, 35, 35),
    image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
    category: 'Abs',
  ),
  Workout(
    id: const Uuid().v1(),
    name: "Pull up",
    type: "WorkoutType.weightAndRep",
    color: const Color.fromARGB(15, 211, 35, 35),
    image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
    category: 'Abs',
  ),
  Workout(
    id: const Uuid().v1(),
    name: "Pull up",
    type: "WorkoutType.weightAndRep",
    color: const Color.fromARGB(15, 211, 35, 35),
    image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
    category: 'Abs',
  ),
  Workout(
    id: const Uuid().v1(),
    name: "Pull up",
    type: "WorkoutType.weightAndRep",
    color: const Color.fromARGB(15, 211, 35, 35),
    image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
    category: 'Abs',
  ),
];

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _listWorkouts = [
    Workout(
      id: const Uuid().v1(),
      name: "Pull up",
      type: "WorkoutType.weightAndRep",
      color: const Color.fromARGB(15, 211, 35, 35),
      image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
      category: 'Abs',
    ),
  ];

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
      // print(t);
      // Workout test = Workout.fromJson(jsonDecode(t));
      // print(test.id);
    }

    // print(jsonToSave);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(kWorkoutList, jsonToSave);
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(kWorkoutList);
    // print(result);

    if (result != null) {
      _listWorkouts = result.map((f) => Workout.fromJson(json.decode(f))).toList();
    }

    notifyListeners();
  }

  Workout findWorkoutById(String id) {
    Workout w = _listWorkouts.singleWhere((element) => element.id == id);
    return w;
  }
}
