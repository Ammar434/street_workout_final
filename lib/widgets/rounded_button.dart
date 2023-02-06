import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.fontSize = 18,
    this.color,
    this.width = double.infinity,
    this.shouldAnimate = false,
    this.height,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String text;
  final bool isLoading;
  final double? height;
  final double fontSize;
  final Color? color;
  final double? width;
  final bool shouldAnimate;
  // final Color secondaryColor;
  @override
  Widget build(BuildContext context) {
    Color? c = color;
    if (color == null) {
      c = Theme.of(context).colorScheme.secondaryContainer;
    }
    return GestureDetector(
      onTap: !isLoading ? onTap : null,
      child: AnimatedContainer(
        margin: const EdgeInsets.all(6),
        width: width,
        height: height ?? kDefaultButtonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: shouldAnimate ? Colors.green : c,
        ),
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  color: Theme.of(context).primaryColor,
                )
              : Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
        ),
      ),
    );
  }
}
