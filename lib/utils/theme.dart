import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';

final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: backgroundColor,
  secondaryKey: primaryColor,
  tertiaryKey: secondaryColor,
  tones: FlexTones.vivid(Brightness.dark),
);

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  colorScheme: schemeDark,
  sliderTheme: SliderThemeData(
    inactiveTickMarkColor: Colors.grey,
    inactiveTrackColor: Colors.grey,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: Colors.black,
    thumbColor: Colors.pinkAccent,
    overlayColor: Colors.pink.withOpacity(0.2),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
    tickMarkShape: const RoundSliderTickMarkShape(),
  ),
);
// ThemeData appTheme = ThemeData.dark().copyWith(
//   visualDensity: VisualDensity.adaptivePlatformDensity,
//   sliderTheme: SliderThemeData(
//     inactiveTickMarkColor: Colors.grey,
//     inactiveTrackColor: Colors.grey,
//     valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
//     valueIndicatorColor: Colors.black,
//     thumbColor: Colors.pinkAccent,
//     overlayColor: Colors.pink.withOpacity(0.2),
//     overlayShape: const RoundSliderOverlayShape(overlayRadius: 32.0),
//     tickMarkShape: const RoundSliderTickMarkShape(),
//   ),
//   scaffoldBackgroundColor: backgroundColor,
//   backgroundColor: backgroundColor,
//   textTheme: const TextTheme(),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//   ),
//   iconTheme: IconThemeData(
//     color: iconColor,
//     size: kDefaultIconsSize,
//   ),
// );
