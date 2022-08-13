import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    Key? key,
    this.isLinear = false,
  }) : super(key: key);
  final bool isLinear;
  @override
  Widget build(BuildContext context) {
    if (isLinear) {
      return Center(
        child: SizedBox(
          height: kSmallPaddingValue,
          width: MediaQuery.of(context).size.width / 3,
          child: LinearProgressIndicator(
            color: tertiaryColor,
            backgroundColor: primaryColor,
          ),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: tertiaryColor,
        backgroundColor: primaryColor,
      ),
    );
  }
}
