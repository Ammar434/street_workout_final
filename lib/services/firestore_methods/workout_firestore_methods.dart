import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/custom_user.dart';
import '../firebase_storage/firebase_storage_methods.dart';

class WorkoutFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorageMethods _storageMethods = FirebaseStorageMethods();

  Future<String> updateUserProfileImage(
    Uint8List file,
  ) async {
    String res = "Some error occured";
    try {
      String url = await _storageMethods.uploadImageToStorage(
        "profilePics",
        file,
        false,
      );

      await _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).update(
        {
          "profileImage": url,
        },
      );

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<String> changeUserFavoriteParc(String parcId) async {
    String res = "Some error occured";
    try {
      _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).update(
        {
          "favoriteParc": parcId,
        },
      );

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<String> updateUserData({
    required int age,
    required double weight,
    required double height,
    required bool gender,
  }) async {
    String res = "Some error occured";
    try {
      _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).update(
        {
          "gender": gender ? "male" : "female",
          "height": height,
          "weight": weight,
          "age": age,
        },
      );

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<String> updateLastPosition({required Position position}) async {
    String res = "Some error occured";
    try {
      _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).update(
        {
          'lastPosition': GeoPoint(position.latitude, position.longitude),
        },
      );

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<String> deleteUserData() async {
    String res = "Some error occured";
    try {
      _firebaseFirestore.collection("users").doc(_firebaseAuth.currentUser!.uid).delete();

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }
}
