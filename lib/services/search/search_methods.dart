//Find a way to find a park give a name and an address should return a unique id

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

String searchParc(String parcName, String parcAddress) {
  return const Uuid().v4();
}

class SearchMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getParcSuggestion(String query) async {
    List<Map<String, dynamic>> list = [];

    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection("datas")
        .doc("all_parcs_references")
        .get();

    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;

    // debugPrint(map.length.toString());
    // debugPrint(map.toString());

    try {
      map.forEach((key, value) {
        // debugPrint(key.toString());
        debugPrint(value.toString());
        list.add(value);
      });

      // for (int i = 0; i < map.length; i++) {
      //   debugPrint(map.);

      //   // Parc p = Parc.postFromSnapshot(doc);
      //   // list.add(p);
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }
}
