import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_storage/firebase_storage_methods.dart';

class RecordVideoMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorageMethods _storageMethods = FirebaseStorageMethods();

  //Check if user have pending video to evaluate
  Future<bool> isUserHavePendingVideo() async {
    bool res = false;
    try {
      DocumentSnapshot documentSnapshot = await _firebaseFirestore.collection("waitting_for_evaluation").doc(_firebaseAuth.currentUser!.uid).get();
      res = documentSnapshot.exists;
    } catch (e) {
      // res = e.toString();
    }

    return res;
  }

  // Add to waitting for evaluation collection
  Future<String> uploadUserVideo(
    File file,
    String challengeId,
  ) async {
    String res = "Some error occured";
    try {
      String url = await _storageMethods.uploadVideoToStorage(
        "videos",
        file,
        false,
      );

      await _firebaseFirestore.collection("waitting_for_evaluation").doc(_firebaseAuth.currentUser!.uid).set(
        {
          "userId": _firebaseAuth.currentUser!.uid,
          "video_url": url,
          "is_valid": false,
          "timestamp": Timestamp.now(),
          "challengeId": challengeId,
        },
      );

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
  // Add video to storage
}
