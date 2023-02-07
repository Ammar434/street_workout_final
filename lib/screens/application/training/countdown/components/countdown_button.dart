import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

class CountDownButton extends StatelessWidget {
  const CountDownButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSmallPaddingValue),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondaryContainer),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
