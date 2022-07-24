import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class TextFIeldForPostScreen extends StatelessWidget {
  const TextFIeldForPostScreen({
    Key? key,
    required this.textEditingControllerParcName,
  }) : super(key: key);

  final TextEditingController textEditingControllerParcName;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingControllerParcName,
      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
      decoration: const InputDecoration(
        hintText: "Enter parc name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tertiaryColor),
          borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
        ),
      ),
    );
  }
}
