import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/custom_user.dart';
import '../../models/material_available.dart';
import '../../models/parc.dart';
import '../../models/post_for_existant_parc.dart';
import '../firebase_storage/firebase_storage_methods.dart';
import 'user_firestore_methods.dart';

class ParcFirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final UserFirestoreMethods _userFirestoreMethods = UserFirestoreMethods();
  final FirebaseStorageMethods _storageMethods = FirebaseStorageMethods();
  final Uuid _uuid = const Uuid();

  Future<String> uploadPost({
    required List listFile,
    required String parcName,
    required List<MaterialAvailable> materialAvailable,
    required String userId,
    required latitude,
    required longitude,
  }) async {
    GeoHasher geoHasher = GeoHasher();
    List<String> materialAvailableString = [];
    String res = "Some error occured";
    if (materialAvailable.isEmpty && parcName.isEmpty && (longitude == 0 && latitude == 0) && listFile.isEmpty) {
      return "Please complete all infos";
    }
    if (materialAvailable.isEmpty) {
      return "Please select one material";
    }
    if (parcName.isEmpty) {
      return "Please enter parc name";
    }

    if (listFile.isEmpty) {
      return "Please sent one photo";
    }
    if ((longitude == 0 && latitude == 0)) {
      return "Please enter a select a valid point on map";
    }
    try {
      // FetchPlaceResponse? detailsResult = await Geolocalisation().getDetailsResultFromGooglePlaceId(placeId);
      for (MaterialAvailable m in materialAvailable) {
        materialAvailableString.add(m.name);
      }
      String postId = _uuid.v1();
      String parcId = _uuid.v1();

      GeoPoint geoPoint = GeoPoint(latitude, longitude);
      // if (detailsResult != null) {
      //   geoPoint = GeoPoint(
      //     detailsResult.place!.latLng!.lat,
      //     detailsResult.place!.latLng!.lng,
      //   );
      // } else {
      //   geoPoint = const GeoPoint(0, 0);
      // }

      Parc post = Parc(
        userUidWhoPublish: userId,
        postId: postId,
        parcId: parcId,
        datePublished: DateTime.now().toString(),
        athletesWhoTrainInThisParc: [],
        materialAvailable: materialAvailableString,
        mainPhoto: '',
        name: parcName,
        completeAddress: "",
        // completeAddress: detailsResult != null ? detailsResult.place!.address! : parcAddress,
        geoPoint: geoPoint,
        userUidChampion: '',
        isPublished: false,
        geoHash: geoHasher.encode(geoPoint.longitude, geoPoint.latitude, precision: 5),
      );

      await _firebaseFirestore.collection("parcs").doc(parcId).set(post.toJson());

      // await _firebaseFirestore.collection("datas").doc("all_parcs_references").update({
      //   parcId: {
      //     "completeAddress": parcAddress,
      //     "name": parcName,
      //     "id": parcId,
      //     "geoPoint": geoPoint,
      //   }
      // });
      for (Uint8List file in listFile) {
        await uploadImageToAExistingParc(
          file: file,
          parcId: parcId,
          userUidWhoPublish: userId,
        );
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore.collection("parcs").doc(parcId).collection("posts").orderBy('likes').get();
      await _firebaseFirestore.collection("parcs").doc(parcId).update(
        {
          "mainPhoto": querySnapshot.docs[0].data()['postUrl'],
        },
      );
      res = "Success";
      // res = await _userFirestoreMethods.incrementUserContribution(listFile.length);
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
        isPublished: false,
      );

      _firebaseFirestore.collection("parcs").doc(parcId).collection("posts").doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<Parc> findParcrById(String id) async {
    Parc? parc;
    try {
      DocumentSnapshot documentSnapshot = await _firebaseFirestore.collection("parcs").doc(id).get();

      parc = Parc.postFromSnapshot(documentSnapshot);
    } catch (e) {
      debugPrint(e.toString());
    }

    return parc!;
  }

  Future<List<String>> getAllImageOfParc(String parcId) async {
    List<String> listUrl = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("parcs")
          .doc(parcId)
          .collection("posts")
          .where(
            "isPublished",
            isEqualTo: true,
          )
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
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firebaseFirestore.collection("parcs").doc(parcId).get();

      for (String uid in documentSnapshot.data()!['athletesWhoTrainInThisParc']) {
        CustomUser customUser = await _userFirestoreMethods.findUserByUid(uid);
        listUser.add(customUser);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return listUser;
  }

  Future<String> addOrRemoveAthleteToAParc({
    required String parcUid,
    required String parcName,
    required String athleteUid,
  }) async {
    String res = "Some error occured";
    try {
      DocumentReference documentReference = _firebaseFirestore.collection("parcs").doc(parcUid);

      DocumentSnapshot documentSnapshot = await documentReference.get();

      List queue = documentSnapshot.get('athletesWhoTrainInThisParc');
      if (queue.contains(athleteUid) == true) {
        documentReference.update({
          "athletesWhoTrainInThisParc": FieldValue.arrayRemove([athleteUid])
        });
        res = await _userFirestoreMethods.removeUserFavoriteParc(parcUid);

        // if (res == "success") {
        //   res = "This parc is no longer your favorite";
        // }
      } else {
        documentReference.update({
          "athletesWhoTrainInThisParc": FieldValue.arrayUnion([athleteUid])
        });
        res = await _userFirestoreMethods.addUserFavoriteParc(parcUid);

        // if (res == "success") {
        //   res = "This parc is no longer your favorite";
        // }
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
