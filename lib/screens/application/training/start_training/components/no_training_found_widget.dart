import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/training/select_training/select_trainning_screen.dart';
import 'package:street_workout_final/screens/application/training/start_training/components/cutom_button_for_trainning_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

class NoTrainingFoundWidget extends StatelessWidget {
  const NoTrainingFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Text("Workout Log Empty"),
          const Spacer(),
          CustomButtonForTrainingScreen(
            iconData: FontAwesomeIcons.plus,
            text: "Start a new workout",
            onTap: () {
              Navigator.pushNamed(context, SelectTrainningScreen.name);
            },
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButtonForTrainingScreen(
                iconData: FontAwesomeIcons.copy,
                text: "Copy previous workout",
                onTap: () {},
              ),
              CustomButtonForTrainingScreen(
                iconData: FontAwesomeIcons.solidCopy,
                text: "Copy someone workout",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
