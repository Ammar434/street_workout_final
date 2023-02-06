import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";


class AlertDialogButtonWidget extends StatelessWidget {
  const AlertDialogButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              kRadiusValue,
            ),
            bottomRight: Radius.circular(
              kRadiusValue,
            ),
          ),
        ),
        child: const Center(
          child: Text(
            "Claim",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
