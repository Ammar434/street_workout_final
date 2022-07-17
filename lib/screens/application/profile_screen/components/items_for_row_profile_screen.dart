import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_circle_user_profile_widget.dart';

class ItemForRowProfileScreen extends StatelessWidget {
  const ItemForRowProfileScreen({
    Key? key,
    required this.value,
    required this.categorieName,
  }) : super(key: key);

  final int value;
  final String categorieName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: kSmallPaddingValue,
          ),
          Text(
            categorieName,
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 12,
              // fontStyle: FontStyle.italic,
              color: hintTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
