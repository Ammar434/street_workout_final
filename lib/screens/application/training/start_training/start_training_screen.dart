import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:provider/provider.dart';

import '../../../../models/custom_user.dart';
import '../../../../provider/training_provider.dart';
import '../../../../provider/user_provider.dart';
import 'components/app_bar_for_trainning.dart';
import 'components/date_select_builder.dart';
import 'components/no_training_found_widget.dart';
import 'components/training_found_widget.dart';

class StartTrainingScreen extends StatelessWidget {
  const StartTrainingScreen({Key? key}) : super(key: key);
  static String name = "StartTrainingScreen";

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    TrainingProvider trainingProvider = Provider.of<TrainingProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarForTrainning(currentUser: currentUser),
              SizedBox(
                height: kPaddingValue * 2,
              ),
              const Text(
                "Ready to train?",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: kPaddingValue * 1,
              ),
              const DateSelectBuilder(),
              SizedBox(
                height: kPaddingValue * 2,
              ),
              Text("Your workout", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: kSmallPaddingValue,
              ),
              trainingProvider.getTrainingOfTheDay() == null ? const NoTrainingFoundWidget() : const TrainingFoundWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
