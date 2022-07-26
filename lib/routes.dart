import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/achievement_screen/achievement_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_screen.dart';
import 'package:street_workout_final/screens/application/favorite_parc/favorite_parc_screen.dart';
import 'package:street_workout_final/screens/application/main_screen.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';
import 'package:street_workout_final/screens/application/start_training/start_training_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/login_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/recover_password_confirm_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/recover_password_screen.dart';
import 'package:street_workout_final/screens/authentication/registration_and_log/register_screen.dart';

import 'screens/authentication/user_information_gathering/gender_screen.dart';
import 'screens/authentication/user_information_gathering/permission_handler_screen.dart';
import 'screens/authentication/user_information_gathering/user_personal_data_screen.dart';
import 'screens/authentication/user_information_gathering/welcome_screen.dart';

//Only for test
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
  AchievementScreen.name: (context) => const AchievementScreen(),
  PostScreen.name: (context) => const PostScreen(),
  ChallengeScreen.name: (context) => const ChallengeScreen(),
  // AccountSettingsScreen.name: (context) => const AccountSettingsScreen(),
  StartTrainingScreen.name: (context) => const StartTrainingScreen(),
  FavoriteParcScreen.name: (context) => const FavoriteParcScreen(),
};
