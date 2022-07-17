import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:street_workout_final/models/post.dart';
import 'package:street_workout_final/services/search/search_parc.dart';
import 'package:street_workout_final/services/storage/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String uid, Uint8List file) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(
        "posts",
        file,
        true,
      );
      String postId = const Uuid().v1();
      Post post = Post(
        userUidWhoPublish: uid,
        postId: postId,
        parcId: searchParc(),
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
        likes: [],
      );
      firebaseFirestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
