import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

ThemeData appTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
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
  scaffoldBackgroundColor: backgroundColor,
  backgroundColor: backgroundColor,
  textTheme: const TextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    color: iconColor,
    size: kDefaultIconsSize,
  ),
);
