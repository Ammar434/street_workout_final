import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../select_training/select_trainning_screen.dart';
import 'cutom_button_for_trainning_screen.dart';

class NoTrainingFoundWidget extends StatelessWidget {
  const NoTrainingFoundWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
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
                onTap: () {
                  showSnackbarBuildLater(globalKey: scaffoldKey);
                },
              ),
              CustomButtonForTrainingScreen(
                iconData: FontAwesomeIcons.solidCopy,
                text: "Copy someone workout",
                onTap: () {
                  showSnackbarBuildLater(globalKey: scaffoldKey);

                  // print(trainingProvider.listTrainingFromProvider.length);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
