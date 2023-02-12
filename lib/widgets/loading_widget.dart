import 'package:flutter/material.dart';
import "../common_libs.dart";

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
          child: LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
