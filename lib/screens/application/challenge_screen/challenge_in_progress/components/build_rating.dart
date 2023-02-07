import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildRating extends StatelessWidget {
  const BuildRating({
    super.key,
    required this.challengerName,
    required this.onTap1,
    required this.onTap2,
  });

  final String challengerName;
  final Function(double) onTap1;
  final Function(double) onTap2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const HorizontalLine(),
          Text(
            "$challengerName managed to do the number of repetitions indicated?",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const FaIcon(
                FontAwesomeIcons.dumbbell,
              ),
              onRatingUpdate: onTap1,
            ),
          ),
          const HorizontalLine(),
          Text(
            "In your opinion how was the global form of the mouvement",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const FaIcon(
                FontAwesomeIcons.dumbbell,
              ),
              onRatingUpdate: onTap2,
            ),
          ),
          const HorizontalLine(),
        ],
      ),
    );
  }
}
