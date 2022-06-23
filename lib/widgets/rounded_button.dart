import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: primaryColor,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
