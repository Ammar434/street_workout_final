import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    String res = "Some error occured";
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost == true) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    try {
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      // debugPrint(downloadUrl);
      return downloadUrl;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  //Utiliser dans profile screen
  Future<List<String>> getAllImageOfAUser(String uid) async {
    List<String> urlList = [];
    Reference ref = firebaseStorage
        .ref()
        .child("posts")
        .child(firebaseAuth.currentUser!.uid);
    try {
      ListResult result = await ref.listAll();

      // debugPrint("-------------------------------------------");
      for (var ref in result.items) {
        String url = await ref.getDownloadURL();
        urlList.add(url);
        // print('Found file: $ref.');
      }
      // debugPrint("-------------------------------------------");
    } catch (e) {
      debugPrint(e.toString());
    }
    return urlList;
  }
}
