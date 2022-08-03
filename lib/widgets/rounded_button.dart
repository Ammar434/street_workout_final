import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.height = 50,
    this.fontSize = 18,
    this.color = primaryColor,
    this.width = double.infinity,
    this.shouldAnimate = false,
    // this.secondaryColor = secondaryColor,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String text;
  final bool isLoading;
  final double height;
  final double fontSize;
  final Color? color;
  final double? width;
  final bool shouldAnimate;
  // final Color secondaryColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isLoading ? onTap : null,
      child: AnimatedContainer(
        margin: const EdgeInsets.all(6),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: shouldAnimate ? Colors.green : color,
        ),
        duration: const Duration(seconds: 1),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: tertiaryColor,
                  color: primaryColor,
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}