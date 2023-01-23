//Find a way to find a park give a name and an address should return a unique id

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/workout.dart';

class SearchMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getParcSuggestion(String query) async {
    List<Map<String, dynamic>> list = [];

    DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("datas").doc("all_parcs_references").get();

    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;

    // debugPrint(map.length.toString());
    // debugPrint(map.toString());
    try {
      map.forEach((key, value) {
        String parcName = (value['name']);
        String parcAddress = value['completeAddress'];

        parcName = parcName.toLowerCase();
        parcAddress = parcAddress.toLowerCase();

        if (parcName.contains(query) || parcAddress.contains(query)) {
          list.add(value);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  List<Workout> getWorkoutSuggestion(String query) {
    List<Workout> list = [];
    // TODO : re activer search bar
    try {
      // for (WorkoutCategory wc in wokoutCategoryList) {
      //   for (Workout w in wc.workoutList) {
      //     if (w.name.contains(query)) {
      //       list.add(w);
      //     }
      //   }
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }
}
