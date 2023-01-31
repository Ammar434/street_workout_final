import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'provider/training_provider.dart';
import 'provider/challenge_provider.dart';
import 'provider/workout_provider.dart';
import 'routes.dart';
import 'authentication_handler.dart';
import 'provider/user_provider.dart';
import 'utils/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['apiKey']!,
        authDomain: dotenv.env['authDomain']!,
        projectId: dotenv.env['projectId']!,
        storageBucket: dotenv.env['storageBucket']!,
        messagingSenderId: dotenv.env['messagingSenderId']!,
        appId: dotenv.env['appId']!,
        measurementId: dotenv.env['measurementId']!,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 830),
      builder: (BuildContext context, Widget? child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ChallengeProvider()),
            ChangeNotifierProvider(create: (_) => TrainingProvider()),
            ChangeNotifierProvider<WorkoutProvider>(create: (_) => WorkoutProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Street Workout Fighter',
            theme: appTheme,
            home: const AuthenticationHandler(),
            routes: routes,
          ),
        );
      },
    );
  }
}
