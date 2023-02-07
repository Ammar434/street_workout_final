import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

class TextFieldForAddWorkout extends StatelessWidget {
  const TextFieldForAddWorkout({
    Key? key,
    required this.textEditingControllerParcName,
  }) : super(key: key);

  final TextEditingController textEditingControllerParcName;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingControllerParcName,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        isDense: true,
        hintText: "Enter exercice name",
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
        ),
      ),
    );
  }
}
