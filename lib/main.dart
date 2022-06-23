import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_workout_final/responsive/mobile_screen_layout.dart';
import 'package:street_workout_final/responsive/responsive_layout.dart';
import 'package:street_workout_final/responsive/web_screen_layout.dart';
import 'package:street_workout_final/utils/colors.dart';

void main() {
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
          theme: ThemeData.dark().copyWith(backgroundColor: backgroundColor),
          home: const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        );
      },
    );
  }
}
