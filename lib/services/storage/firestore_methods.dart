import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:street_workout_final/models/material_available.dart';
import 'package:street_workout_final/models/post.dart';
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
    String photoUrl = "";
    String res = "Some error occured";
    try {
      for (Uint8List file in listFile) {
        photoUrl = await StorageMethods().uploadImageToStorage(
          "posts",
          file,
          true,
        );
        photoUrlList.add(photoUrl);
      }
      for (MaterialAvailable m in materialAvailable) {
        materialAvailableString.add(m.name);
      }
      String postId = const Uuid().v1();
      String parcId = searchParc(parcName, parcAddress);

      Post post = Post(
        userUidWhoPublish: uid,
        postId: postId,
        parcId: parcId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrlList,
        likes: [],
        materialAvailable: materialAvailableString,
      );

      firebaseFirestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
