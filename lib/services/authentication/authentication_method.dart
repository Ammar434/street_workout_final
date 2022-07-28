import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/custom_user.dart';
import '../storage/storage_methods.dart';

Uint8List? temporaryUserImage;
double temporaryWeightValue = 0;
double temporaryAgeValue = 0;
double temporaryHeightValue = 0;
String temporaryGender = "male";

class AuthenticationMethod {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

  Future<String> checkInfoRegisterUser({
    required String email,
    required String password,
    required String passwordConfirm,
    required String userName,
    required Uint8List profileImage,
  }) async {
    String res = "Some error occured";
    bool isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty && isEmailValid) {
      res = "Please check you're email ";
    } else if (password.isEmpty || passwordConfirm.isEmpty) {
      res = "Please enter a password";
    } else if (password.length < 8) {
      res = "Please enter a password of at least 8 characters";
    } else if (password != passwordConfirm) {
      res = "You're password are not the same";
    } else if (userName.isEmpty) {
      res = "Please enter a username";
    } else {
      temporaryUserImage = profileImage;
      await writeSecureUserData(
        email: email,
        password: password,
        userName: userName,
      );
      res = "success";
    }
    return res;
  }

  Future<void> writeSecureUserData({
    required String email,
    required String password,
    required String userName,
  }) async {
    await storage.write(key: "KEY_EMAIL", value: email);
    await storage.write(key: "KEY_PASSWORD", value: password);
    await storage.write(key: "KEY_USER_NAME", value: userName);
  }

  Future<String?> getUserNameFromSecureStorage() async {
    String? a = await storage.read(key: "KEY_USER_NAME");
    return a;
  }

  Future<String> getUserPasswordFromSecureStorage() async {
    String? a = await storage.read(key: "KEY_PASSWORD");
    return a ?? "UNKNOWN";
  }

  Future<String> getUserEmailromSecureStorage() async {
    String? a = await storage.read(key: "KEY_EMAIL");
    return a ?? "UNKNOWN";
  }

  Future<String> registerUser() async {
    String res = "Some error occured";

    try {
      String? userName = await getUserNameFromSecureStorage();
      String? password = await getUserPasswordFromSecureStorage();
      String? email = await getUserEmailromSecureStorage();
      debugPrint("-----------------------");
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String profileImageUrl = await StorageMethods().uploadImageToStorage(
        "profilePics",
        temporaryUserImage!,
        false,
      );
      CustomUser customUser = CustomUser(
        uid: credential.user!.uid,
        userName: userName!,
        profileImage: profileImageUrl,
        gender: temporaryGender,
        age: temporaryAgeValue.toInt(),
        weight: temporaryWeightValue,
        height: temporaryHeightValue,
        follower: [],
        following: [],
        points: 0,
        favoriteParc: "",
        numberOfContribution: 0,
        numberOfEvaluation: 0,
        instagramProfile: "",
        rewards: {
          "strength": [],
          "social": [],
          "mental": [],
          "others": [],
        },
      );
      await firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(customUser.toJson());
      res = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "The email is badly formatted";
      } else if (error.code == "week-password") {
        res = "Please enter a stronger password";
      } else if (error.code == "email-already-in-use") {
        res = "This email is already used in our database";
      }
    } catch (e) {
      res = e.toString();
    }
    temporaryUserImage = null;
    temporaryWeightValue = 0;
    temporaryAgeValue = 0;
    temporaryHeightValue = 0;
    temporaryGender = "male";
    await storage.deleteAll();
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signOut() async {
    String res = "Some error occured";
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
