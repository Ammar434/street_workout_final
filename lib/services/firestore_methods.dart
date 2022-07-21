import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/material_available.dart';
import 'package:street_workout_final/models/post_for_existant_parc.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/services/search/search_parc.dart';
import 'package:street_workout_final/services/storage/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required List listFile,
    required String parcName,
    required String parcAddress,
    required List<MaterialAvailable> materialAvailable,
    required String uid,
  }) async {
    List<String> photoUrlList = [];
    List<String> materialAvailableString = [];
    String res = "Some error occured";

    try {
      for (MaterialAvailable m in materialAvailable) {
        materialAvailableString.add(m.name);
      }
      String postId = const Uuid().v1();
      String parcId = searchParc(parcName, parcAddress);

      Parc post = Parc(
        userUidWhoPublish: uid,
        postId: postId,
        parcId: parcId,
        datePublished: DateTime.now().toString(),
        athletesWhoTrainInThisParc: [],
        materialAvailable: materialAvailableString,
        mainPhoto: '',
        name: parcName,
        completeAddress: parcAddress,
        geoPoint: const GeoPoint(1, 1),
        userUidChampion: '',
      );

      await firebaseFirestore
          .collection("parcs")
          .doc(parcId)
          .set(post.toJson());
      for (Uint8List file in listFile) {
        await uploadImageToAExistingParc(
          file: file,
          parcId: parcId,
          userUidWhoPublish: uid,
        );
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection("parcs")
              .doc(parcId)
              .collection("posts")
              .orderBy('likes')
              .get();
      await firebaseFirestore.collection("parcs").doc(parcId).update(
        {
          "mainPhoto": querySnapshot.docs[0].data()['postUrl'],
        },
      );
      res = await incrementUserContribution(uid);
    } catch (e) {
      debugPrint("-------------------------------------------------");
      debugPrint(e.toString());

      debugPrint("-------------------------------------------------");
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadImageToAExistingParc({
    required Uint8List file,
    required String parcId,
    required String userUidWhoPublish,
  }) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        "posts",
        file,
        true,
      );
      String postId = const Uuid().v1();

      PostForExistantParc post = PostForExistantParc(
        userUidWhoPublish: userUidWhoPublish,
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
        likes: [],
      );

      firebaseFirestore
          .collection("parcs")
          .doc(parcId)
          .collection("posts")
          .doc(postId)
          .set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

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

  Future<String> incrementUserContribution(String uid) async {
    CustomUser? user;
    String res = "Some error occured";
    try {
      await firebaseFirestore.collection("users").doc(uid).update(
        {
          "numberOfContribution": FieldValue.increment(1),
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
