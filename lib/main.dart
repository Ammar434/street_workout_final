import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/routes.dart';
import 'package:street_workout_final/utils/theme.dart';
import 'authentication_handler.dart';

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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
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
