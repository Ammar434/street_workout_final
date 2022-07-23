import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class MyLocationMarker extends AnimatedWidget {
  const MyLocationMarker(
    Animation<double> animation, {
    Key? key,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    double size = 50;
    double newValue = lerpDouble(0.5, 1.0, value)!;
    return Stack(
      children: [
        Center(
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Container(
            width: size * newValue,
            height: size * newValue,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
