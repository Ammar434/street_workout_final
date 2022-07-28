import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

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
          width: MediaQuery.of(context).size.width / 3,
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
