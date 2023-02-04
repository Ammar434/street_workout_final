import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/challenge_screen/waitting_room/challenger_waitting_room/challenger_waitting_room_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/waitting_room/evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import 'screens/application/training/select_training/select_trainning_screen.dart';
import 'screens/application/achievement_screen/achievement_screen.dart';
import 'screens/application/challenge_screen/challenge_start/challenge_start_screen.dart';
// import 'screens/application/challenge_screen/challenger_waitting_room/challenger_waitting_room_screen.dart';
// import 'screens/application/challenge_screen/evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import 'screens/application/home_screen/view_all_parc/view_all_parc_screen.dart';
import 'screens/application/main_screen.dart';
import 'screens/application/post_screen/post_screen.dart';
import 'screens/application/settings_screen/account_notification/account_notification_screen.dart';
// import 'screens/application/training/select_training/select_trainning_screen.dart';
import 'screens/authentication/login_screen/login_screen.dart';
import 'screens/authentication/recover_password_screen/recover_password_confirm_screen.dart';
import 'screens/authentication/recover_password_screen/recover_password_screen.dart';
import 'screens/authentication/register_screen/register_screen.dart';

import 'screens/application/training/start_training/start_training_screen.dart';
import 'screens/authentication/user_information_gathering/gender_screen.dart';
import 'screens/authentication/user_information_gathering/permission_handler_screen.dart';
import 'screens/authentication/user_information_gathering/user_personal_data_screen.dart';
import 'screens/authentication/user_information_gathering/welcome_screen.dart';

//Only for test
Map<String, WidgetBuilder> routes = {
  LoginScreen.name: (context) => const LoginScreen(),
  RegisterScreen.name: (context) => const RegisterScreen(),
  RecoverPasswordScreen.name: (context) => const RecoverPasswordScreen(),
  RecoverPasswordConfirmScreen.name: (context) => const RecoverPasswordConfirmScreen(),
  WelcomeScreen.name: (context) => const WelcomeScreen(),
  GenderScreen.name: (context) => const GenderScreen(),
  UserPersonalDataScreen.name: (context) => const UserPersonalDataScreen(),
  PermissionHandlerScreen.name: (context) => const PermissionHandlerScreen(),
  MainScreen.name: (context) => const MainScreen(),
  AchievementScreen.name: (context) => const AchievementScreen(),
  PostScreen.name: (context) => const PostScreen(),
  ChallengeStartScreen.name: (context) => const ChallengeStartScreen(),
  StartTrainingScreen.name: (context) => const StartTrainingScreen(),
  // FavoriteParcEmptyScreen.name: (context) => const FavoriteParcEmptyScreen(),
  EvaluatorWaittingRoomScreen.name: (context) => const EvaluatorWaittingRoomScreen(),
  ChallengerWaittinRoomScreen.name: (context) => const ChallengerWaittinRoomScreen(),
  ViewAllParcScreen.name: (context) => const ViewAllParcScreen(),
  AccountNotificationScreen.name: (context) => const AccountNotificationScreen(),
  SelectTrainningScreen.name: (context) => const SelectTrainningScreen(),
};
