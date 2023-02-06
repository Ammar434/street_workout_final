import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../widgets/rounded_button.dart';

class FavoriteParcEmptyScreen extends StatelessWidget {
  const FavoriteParcEmptyScreen({Key? key, required this.displayButton}) : super(key: key);
  static String name = "FavoriteParcEmpty";
  final bool displayButton;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  "assets/images/errors/error_1.png",
                ),
              ),
              Text(
                "To access this part of the application, please select at least one favorite parc",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: kPaddingValue * 1,
              ),
              Text(
                "You can do it by clicking on a parc and then set it as the parc where you train",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: kPaddingValue * 5,
              ),
              if (displayButton)
                RoundedButton(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  text: "Select parc",
                )
            ],
          ),
        ),
      ),
    );
  }
}
