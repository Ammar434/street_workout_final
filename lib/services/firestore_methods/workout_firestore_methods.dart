import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/workout.dart';

class WorkoutFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> addWorkoutToFirestore(
    String id,
    String name,
    String type,
    Color color,
    String image,
    String category,
  ) async {
    String res = "Some error occurred";
    Workout workout = Workout(
      id: id,
      name: name,
      type: type,
      color: color,
      image: image,
      category: category,
    );

    try {
      await _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).collection("workouts").doc(workout.id).set(
            workout.toJson(),
          );
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<List<Workout>> getWorkoutSnapshot() async {
    List<Workout> listWorkout = [];
    final QuerySnapshot<Map<String, dynamic>> workoutQuery = await _firebaseFirestore.collection("workout").get();

    for (int i = 0; i < workoutQuery.size; i++) {
      final DocumentSnapshot document = workoutQuery.docs.elementAt(i);
      Map<dynamic, dynamic> documentMap = document.data() as Map<dynamic, dynamic>;
      listWorkout.add(
        Workout.fromJson(documentMap),
      );
    }

    return listWorkout;
  }
}
