import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';

class CustomDialogBodyWidget extends StatelessWidget {
  const CustomDialogBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Spacer(),
                    Lottie.network(
                      "https://assets7.lottiefiles.com/packages/lf20_touohxv0.json",
                      repeat: false,
                      height: kPaddingValue * 15,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    ),
                    Text("Congrats!", style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      "You already have this reward",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              //   Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
