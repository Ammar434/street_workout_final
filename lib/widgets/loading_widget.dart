import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
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
          width: 80.sp,
          child: const LinearProgressIndicator(
            color: tertiaryColor,
            backgroundColor: primaryColor,
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(
        color: tertiaryColor,
        backgroundColor: primaryColor,
      ),
    );
  }
}
