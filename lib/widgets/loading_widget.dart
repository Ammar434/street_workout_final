import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: tertiaryColor,
        backgroundColor: primaryColor,
      ),
    );
  }
}
