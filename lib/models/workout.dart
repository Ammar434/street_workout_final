import 'package:flutter/material.dart';
import 'package:street_workout_final/models/sets.dart';
import 'package:uuid/uuid.dart';

enum WorkoutType {
  weightAndRep,
  distanceAndTime,
}

class WorkoutCategory {
  WorkoutCategory({
    required this.name,
    required this.color,
    required this.workoutList,
  });

  final String name;

  final Color color;
  final List<Workout> workoutList;
}

class Workout {
  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.image,
    required this.listSets,
  });
  //Set and rep time weight....
  final WorkoutType type;
  final String id;
  final String name;
  final String image;
  List<Sets> listSets;
  //Set and rep time weight....

  final Color color;

  void addSetOfRep(double weight, int numberOfRep) {
    Sets set = Sets(
      numberOfRep: numberOfRep,
      weight: weight,
      distance: 0,
      duration: Duration.zero,
    );
    listSets.add(set);
  }

  Workout clone() {
    return Workout(
      id: id,
      name: name,
      type: type,
      color: color,
      image: image,
      listSets: [],
    );
  }
}

List<WorkoutCategory> wokoutCategoryList = [
  WorkoutCategory(
    name: "Abs",
    color: const Color(0x0ff00000),
    workoutList: [
      Workout(
        id: const Uuid().v1(),
        name: "Ab-Wheel Rollout",
        type: WorkoutType.weightAndRep,
        color: const Color.fromARGB(15, 211, 35, 35),
        image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
        listSets: [],
      ),
      Workout(
        id: const Uuid().v1(),
        name: "Ab-Wheel Rollout",
        type: WorkoutType.weightAndRep,
        color: const Color.fromARGB(15, 211, 35, 35),
        image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
        listSets: [],
      ),
    ],
  ),
  WorkoutCategory(
    name: "Back",
    color: const Color.fromARGB(15, 64, 0, 240),
    workoutList: [
      Workout(
        id: const Uuid().v1(),
        name: "Pull up",
        type: WorkoutType.weightAndRep,
        color: const Color.fromARGB(15, 211, 35, 35),
        image: "https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop",
        listSets: [],
      ),
    ],
  ),
  WorkoutCategory(
    name: "Biceps",
    color: const Color.fromARGB(15, 0, 240, 128),
    workoutList: [
      Workout(
        id: const Uuid().v1(),
        name: "Chin up",
        type: WorkoutType.weightAndRep,
        color: const Color.fromARGB(15, 211, 35, 35),
        image: 'https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop',
        listSets: [],
      ),
    ],
  ),
  WorkoutCategory(
    name: "Cardio",
    color: const Color.fromARGB(15, 0, 240, 128),
    workoutList: [
      Workout(
        id: const Uuid().v1(),
        name: "Cycling",
        type: WorkoutType.distanceAndTime,
        color: const Color.fromARGB(15, 211, 35, 35),
        image: 'https://images.contentstack.io/v3/assets/blt45c082eaf9747747/blt546bfa7d4976da24/5de0b808f623107d34dbf973/beginner_pullups.jpg?width=1200&height=630&fit=crop',
        listSets: [],
      ),
    ],
  ),
];
