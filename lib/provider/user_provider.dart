import 'package:flutter/cupertino.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/authentication/authentication_method.dart';

class UserProvider with ChangeNotifier {
  CustomUser? _customUser;
  final AuthenticationMethod _authenticationMethod = AuthenticationMethod();
  CustomUser get getUser => _customUser!;
  Future<void> refreshUser() async {
    CustomUser customUser = await _authenticationMethod.getUserDetails();
    _customUser = customUser;
    notifyListeners();
  }
}
