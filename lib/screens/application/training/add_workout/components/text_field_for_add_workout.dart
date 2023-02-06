import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

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
          borderSide: const BorderSide(color: tertiaryColor),
          borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
        ),
      ),
    );
  }
}
