import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/custom_user.dart';
import '../storage/storage_methods.dart';

class UserFirestoreMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final StorageMethods storageMethods = StorageMethods();

  Future<CustomUser> findUserByUid(String uid) async {
    CustomUser? user;
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection("users").doc(uid).get();

      user = CustomUser.userFromSnapshot(documentSnapshot);
    } catch (e) {
      debugPrint(e.toString());
      if (user == null) {
        DocumentSnapshot documentSnapshot = await firebaseFirestore
            .collection("users")
            .doc("kEvs6AAbs5Xov7kUHtae5SdEIls1")
            .get();

        user = CustomUser.userFromSnapshot(documentSnapshot);
      }
    }

    return user;
  }

  Future<String> incrementUserContribution(int value) async {
    String res = "Some error occured";
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .update(
        {
          "numberOfContribution": FieldValue.increment(value),
        },
      );

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future<String> updateUserProfileImage(
    Uint8List file,
  ) async {
    String res = "Some error occured";
    try {
      String url = await storageMethods.uploadImageToStorage(
        "profilePics",
        file,
        false,
      );

      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .update(
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
}
