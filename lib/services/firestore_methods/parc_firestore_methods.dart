import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/post_for_existant_parc.dart';
import 'package:street_workout_final/services/firestore_methods/user_firestore_methods.dart';
import 'package:uuid/uuid.dart';

import '../../models/custom_user.dart';
import '../../models/material_available.dart';
import '../../models/parc.dart';
import '../storage/storage_methods.dart';

class ParcFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final UserFirestoreMethods _userFirestoreMethods = UserFirestoreMethods();
  final StorageMethods _storageMethods = StorageMethods();
  final Uuid _uuid = const Uuid();

  Future<String> uploadPost({
    required List listFile,
    required String parcName,
    required String parcAddress,
    required List<MaterialAvailable> materialAvailable,
    required String uid,
  }) async {
    List<String> materialAvailableString = [];
    String res = "Some error occured";

    try {
      for (MaterialAvailable m in materialAvailable) {
        materialAvailableString.add(m.name);
      }
      String postId = _uuid.v1();
      String parcId = _uuid.v1();

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
        isPublished: false,
      );

      await _firebaseFirestore
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
          await _firebaseFirestore
              .collection("parcs")
              .doc(parcId)
              .collection("posts")
              .orderBy('likes')
              .get();
      await _firebaseFirestore.collection("parcs").doc(parcId).update(
        {
          "mainPhoto": querySnapshot.docs[0].data()['postUrl'],
        },
      );
      res = await _userFirestoreMethods
          .incrementUserContribution(listFile.length);
    } catch (e) {
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
      String photoUrl = await _storageMethods.uploadImageToStorage(
        "posts",
        file,
        true,
      );
      String postId = _uuid.v1();

      PostForExistantParc post = PostForExistantParc(
        userUidWhoPublish: userUidWhoPublish,
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
        likes: [],
      );

      _firebaseFirestore
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

  Future<Parc> findParcrById(String id) async {
    late Parc parc;
    try {
      DocumentSnapshot documentSnapshot =
          await _firebaseFirestore.collection("parcs").doc(id).get();

      parc = Parc.postFromSnapshot(documentSnapshot);
    } catch (e) {
      debugPrint(e.toString());
    }

    return parc;
  }

  Future<List<String>> getAllImageOfParc(String parcId) async {
    List<String> listUrl = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("parcs")
              .doc(parcId)
              .collection("posts")
              .get();
      for (var document in querySnapshot.docs) {
        String s = document.data()['postUrl'];
        listUrl.add(s);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return listUrl;
  }

  Future<List<CustomUser>> getAllAthleteOfParc(String parcId) async {
    List<CustomUser> listUser = [];
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firebaseFirestore.collection("parcs").doc(parcId).get();

      for (String uid
          in documentSnapshot.data()!['athletesWhoTrainInThisParc']) {
        CustomUser customUser = await _userFirestoreMethods.findUserByUid(uid);
        listUser.add(customUser);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return listUser;
  }

  Future<String> addOrRemoveAthleteToAParc(
      String parcUid, String athleteUid) async {
    String res = "Some error occured";
    try {
      DocumentReference documentReference =
          _firebaseFirestore.collection("parcs").doc(parcUid);
      DocumentReference documentReferenceUser =
          _firebaseFirestore.collection("users").doc(athleteUid);
      DocumentSnapshot documentSnapshot = await documentReference.get();

      List queue = documentSnapshot.get('athletesWhoTrainInThisParc');
      if (queue.contains(athleteUid) == true) {
        documentReference.update({
          "athletesWhoTrainInThisParc": FieldValue.arrayRemove([athleteUid])
        });
        documentReferenceUser.update({
          "favoriteParc": "",
        });
      } else {
        documentReference.update({
          "athletesWhoTrainInThisParc": FieldValue.arrayUnion([athleteUid])
        });
        documentReferenceUser.update({
          "favoriteParc": parcUid,
        });
      }
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
