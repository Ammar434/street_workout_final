import 'package:flutter/material.dart';

import 'package:street_workout_final/utils/constants.dart';

class ParcDisplayCardImage extends StatelessWidget {
  const ParcDisplayCardImage({
    Key? key,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);
  final String imageUrl;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kRadiusValue),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
