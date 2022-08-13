import 'package:flutter/material.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/utils/constants.dart';

class ParcMainPhoto extends StatelessWidget {
  ParcMainPhoto({
    Key? key,
    required this.parc,
  }) : super(key: key);

  final Parc parc;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          image: DecorationImage(
            image: NetworkImage(parc.mainPhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
