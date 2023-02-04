import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/custom_user.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CustomUser? _customUser;
  CustomUser? get getUser => _customUser;

  UserProvider() {
    refreshUser();
  }

  Future<void> refreshUser() async {
    FirebaseFirestore.instance.collection('users').doc(firebaseAuth.currentUser!.uid).snapshots().listen((event) {
      _customUser = CustomUser.userFromSnapshot(event);
      notifyListeners();
    });
  }
}
