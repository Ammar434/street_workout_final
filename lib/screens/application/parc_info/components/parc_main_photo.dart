import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../models/parc.dart';

class ParcMainPhoto extends StatelessWidget {
  const ParcMainPhoto({
    Key? key,
    required this.parc,
  }) : super(key: key);

  final Parc parc;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (parc.mainPhoto.isEmpty) {
      imageProvider = const AssetImage(
        "assets/images/errors/no_picture.png",
      );
    } else {
      imageProvider = NetworkImage(parc.mainPhoto);
    }

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
