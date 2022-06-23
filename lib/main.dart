import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_workout_final/responsive/mobile_screen_layout.dart';
import 'package:street_workout_final/responsive/responsive_layout.dart';
import 'package:street_workout_final/responsive/web_screen_layout.dart';
import 'package:street_workout_final/screens/authentication/login_screen.dart';
import 'package:street_workout_final/screens/authentication/recover_password_confirm_screen.dart';
import 'package:street_workout_final/screens/authentication/recover_password_screen.dart';
import 'package:street_workout_final/screens/authentication/register_screen.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/gender_screen.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/permission_handler_screen.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/user_personal_data_screen.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/welcome_screen.dart';
import 'package:street_workout_final/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_T8SG6SRXpgMhW5oFAO8RITBVNJmPDFY",
        authDomain: "streetworkoutfighter.firebaseapp.com",
        projectId: "streetworkoutfighter",
        storageBucket: "streetworkoutfighter.appspot.com",
        messagingSenderId: "37349665099",
        appId: "1:37349665099:web:e95bb2a482d15d30cb20ce",
        measurementId: "G-FGTK80JW29",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 830),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Street Workout Fighter',
          theme: ThemeData.dark().copyWith(
            sliderTheme: SliderThemeData(
              inactiveTickMarkColor: Theme.of(context).disabledColor,
              inactiveTrackColor: Theme.of(context).disabledColor,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.black,
              thumbColor: Colors.pinkAccent,
              overlayColor: Colors.pink.withOpacity(0.2),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
              tickMarkShape: RoundSliderTickMarkShape(),
            ),
            scaffoldBackgroundColor: backgroundColor,
            backgroundColor: backgroundColor,
            textTheme: TextTheme(),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                ),
            LoginScreen.name: (context) => const LoginScreen(),
            RegisterScreen.name: (context) => const RegisterScreen(),
            RecoverPasswordScreen.name: (context) => const RecoverPasswordScreen(),
            RecoverPasswordConfirmScreen.name: (context) => const RecoverPasswordConfirmScreen(),
            WelcomeScreen.name: (context) => const WelcomeScreen(),
            GenderScreen.name: (context) => const GenderScreen(),
            UserPersonalDataScreen.name: (context) => const UserPersonalDataScreen(),
            PermissionHandlerScreen.name: (context) => const PermissionHandlerScreen(),
          },
        );
      },
    );
  }
}
