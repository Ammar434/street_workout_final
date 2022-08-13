import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

class FirebaseStorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    String res = "Some error occured";
    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isPost == true) {
      String id = Uuid().v1();
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
    Reference ref = firebaseStorage.ref().child("posts").child(firebaseAuth.currentUser!.uid);
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<String> deleteUserStorage() async {
    String res = "Some error occured";
    try {
      Reference ref = firebaseStorage.ref().child("profilePics").child(firebaseAuth.currentUser!.uid);

      await ref.delete();

      res = "success";
    } catch (e) {
      debugPrint(e.toString());
      res = e.toString();
    }

    return res;
  }
}
