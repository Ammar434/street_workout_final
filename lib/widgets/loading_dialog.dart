import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';

import 'loading_widget.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    // The user CANNOT close this dialog  by pressing outsite it
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return Dialog(
        // The background color
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusValue),
        ),
        child: const Center(child: LoadingWidget()),
      );
    },
  );
}
