import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';

import 'alert_dialog_button_widget.dart';

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
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer(),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      radius: 80,
                      child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_touohxv0.json", repeat: false),
                    ),
                    SizedBox(
                      height: kPaddingValue,
                    ),
                    Text(
                      "Congrats!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "You just Unlocked New Level",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              //   Spacer(),
              const AlertDialogButtonWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
