import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'text_style.dart';

ThemeData initTheme() {
  Color backgroundColor = const Color(0xff010819);
  Color primaryColor = const Color(0xffE5532E);
  // Color secondaryColor = const Color(0xffD59A72);
  // Color tertiaryColor = const Color(0xff9AABBB);
  // Color hintTextColor = const Color(0xff8C92AC);
  Color iconColor = const Color(0xffFAF9F6);

  final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: backgroundColor,
    secondaryKey: primaryColor,
    tertiaryKey: iconColor,
    tones: FlexTones.vivid(Brightness.dark),
  );

  TextThemeProvider textThemeProvider = TextThemeProvider();

  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // brightness: Brightness.dark,
    colorScheme: schemeDark,
    textTheme: TextTheme(
      titleLarge: textThemeProvider.h2,
      titleMedium: textThemeProvider.title1,
      titleSmall: textThemeProvider.title2,
      bodyLarge: textThemeProvider.body,
      bodyMedium: textThemeProvider.bodySmall,
      bodySmall: textThemeProvider.bodySmall,
      labelLarge: textThemeProvider.btn,
    ),
  );

  return appTheme;
}









// ThemeData appTheme = ThemeData.dark().copyWith(
//   visualDensity: VisualDensity.adaptivePlatformDensity,
//   sliderTheme: SliderThemeData(
//     inactiveTickMarkColor: Colors.grey,
//     inactiveTrackColor: Colors.grey,
//     valueIndicatorShape:  PaddleSliderValueIndicatorShape(),
//     valueIndicatorColor: Colors.black,
//     thumbColor: Colors.pinkAccent,
//     overlayColor: Colors.pink.withOpacity(0.2),
//     overlayShape:  RoundSliderOverlayShape(overlayRadius: 32.0),
//     tickMarkShape:  RoundSliderTickMarkShape(),
//   ),
//   scaffoldBackgroundColor: backgroundColor,
//   backgroundColor: backgroundColor,
//   textTheme:  TextTheme(),
//   appBarTheme:  AppBarTheme(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//   ),
//   iconTheme: IconThemeData(
//     color: iconColor,
//     size: kDefaultIconsSize,
//   ),
// );
