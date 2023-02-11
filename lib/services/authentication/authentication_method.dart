import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/custom_user.dart';
import '../firebase_storage/firebase_storage_methods.dart';
import '../firestore_methods/user_firestore_methods.dart';
import '../secure_storage/secure_storage_methods.dart';

Uint8List? temporaryUserImage;
double temporaryWeightValue = 0;
double temporaryAgeValue = 0;
double temporaryHeightValue = 0;
String temporaryGender = "male";

class AuthenticationMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorageMethods _firebaseStorageMethods = FirebaseStorageMethods();
  final SecureStorageMethods _secureStorageMethods = SecureStorageMethods();

  bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  Future<String> checkInfoRegisterUser({
    required String email,
    required String password,
    required String passwordConfirm,
    required String userName,
    required Uint8List profileImage,
  }) async {
    if (email.isEmpty || !isEmailValid(email)) {
      return "Please check you're email ";
    }
    if (userName.isEmpty || userName.length < 4) {
      return "Please enter a longer name";
    }
    if (password.isEmpty || passwordConfirm.isEmpty) {
      return "Please enter a password";
    }
    if (password.length < 8) {
      return "Please enter a password of at least 8 characters";
    }
    if (password != passwordConfirm) {
      return "You're password are not the same";
    }

    temporaryUserImage = profileImage;
    await _secureStorageMethods.writeSecureUserData(
      email: email,
      password: password,
      userName: userName,
    );

    return "success";
  }

  Future<String> registerUser(GeoPoint geoPoint) async {
    String res = "Some error occured";

    try {
      String? userName = await _secureStorageMethods.getUserNameFromSecureStorage();
      String? password = await _secureStorageMethods.getUserPasswordFromSecureStorage();
      String? email = await _secureStorageMethods.getUserEmailromSecureStorage();
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String profileImageUrl = await _firebaseStorageMethods.uploadImageToStorage(
        "profilePics",
        temporaryUserImage!,
        false,
      );
      CustomUser customUser = CustomUser(
        uid: credential.user!.uid,
        userName: userName,
        profileImage: profileImageUrl,
        gender: temporaryGender,
        age: temporaryAgeValue.toInt(),
        weight: temporaryWeightValue,
        height: temporaryHeightValue,
        follower: [],
        following: [],
        points: 0,
        favoriteParc: [],
        numberOfContribution: 0,
        numberOfEvaluation: 0,
        instagramProfile: "",
        rewards: [],
        lastPosition: geoPoint,
        isAdmin: false,
      );
      await _firebaseFirestore.collection('users').doc(credential.user!.uid).set(customUser.toJson());
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

    await _secureStorageMethods.deleteAll();
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
      await _firebaseAuth.signOut();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deleteUser({
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (password.isNotEmpty) {
        User firebaseUser = _firebaseAuth.currentUser!;
        String userEmail = firebaseUser.email!;

        await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: password);
        await UserFirestoreMethods().deleteUserData();
        await _firebaseStorageMethods.deleteUserStorage();
        await firebaseUser.delete();

        res = "success";
      } else {
        res = "Please enter a password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> resetPassword({
    required String email,
  }) async {
    String res = "Some error occured";

    if (email.isEmpty) return "Please enter a email";
    if (!isEmailValid(email)) return "Please enter a valid email";

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      res = "success";
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        res = "No record found of this mail";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
