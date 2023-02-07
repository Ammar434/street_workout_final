import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          Text(
            categorieName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
