import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_screen.dart';
import 'package:street_workout_final/screens/application/main_screen.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';

import 'package:street_workout_final/screens/authentication/registration_and_log/login_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/recover_password_confirm_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/recover_password_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/register_screen.dart';

import 'screens/authentication/user_information_gathering/gender_screen.dart';
import 'screens/authentication/user_information_gathering/permission_handler_screen.dart';
import 'screens/authentication/user_information_gathering/user_personal_data_screen.dart';
import 'screens/authentication/user_information_gathering/welcome_screen.dart';

Map<String, WidgetBuilder> routes = {
  LoginScreen.name: (context) => const LoginScreen(),
  RegisterScreen.name: (context) => const RegisterScreen(),
  RecoverPasswordScreen.name: (context) => const RecoverPasswordScreen(),
  RecoverPasswordConfirmScreen.name: (context) =>
      const RecoverPasswordConfirmScreen(),
  WelcomeScreen.name: (context) => const WelcomeScreen(),
  GenderScreen.name: (context) => const GenderScreen(),
  UserPersonalDataScreen.name: (context) => const UserPersonalDataScreen(),
  PermissionHandlerScreen.name: (context) => const PermissionHandlerScreen(),
  MainScreen.name: (context) => const MainScreen(),
  // ParcInfoScreen.name: (context) => const ParcInfoScreen(),
  AchievementScreen.name: (context) => const AchievementScreen(),
  // ProfileScreen.name: (context) => const ProfileScreen(user: ,),
  PostScreen.name: (context) => const PostScreen(),
  ChallengeScreen.name: (context) => const ChallengeScreen(),
};
