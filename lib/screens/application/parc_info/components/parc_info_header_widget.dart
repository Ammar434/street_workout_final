import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:street_workout_final/utils/constants.dart';

import '../../../../../widgets/solid_circle_chevron_left.dart';

class ParcInfoHeaderWidget extends StatelessWidget {
  const ParcInfoHeaderWidget({
    Key? key,
    required this.parcImage,
  }) : super(key: key);

  final String parcImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(parcImage), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 5,
          top: kPaddingValue * 1.5,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const SolidCircleChevronLeft(),
          ),
        ),
        const Positioned(
          right: 5,
          top: kPaddingValue * 1.5,
          child: LikeButton(),
        ),
      ],
    );
  }
}
