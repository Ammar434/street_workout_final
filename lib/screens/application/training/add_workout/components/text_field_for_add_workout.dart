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
      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
      decoration: InputDecoration(
        hintText: "Enter exercice name",
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
        ),
      ),
    );
  }
}
