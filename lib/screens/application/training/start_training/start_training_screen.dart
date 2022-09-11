import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/provider/training_provider.dart';
import 'package:street_workout_final/screens/application/training/start_training/components/no_training_found_widget.dart';
import 'package:street_workout_final/screens/application/training/start_training/components/training_found_widget.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/user_provider.dart';
import 'components/app_bar_for_trainning.dart';
import 'components/date_select_builder.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_style.dart';

class StartTrainingScreen extends StatelessWidget {
  const StartTrainingScreen({Key? key}) : super(key: key);
  static String name = "StartTrainingScreen";

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    TrainingProvider trainingProvider = Provider.of<TrainingProvider>(context);
    Training? trainingOfTheDay = trainingProvider.getTrainingOfTheDay();
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
              Text("Your workout", style: kTextStyleImportance3),
              trainingOfTheDay == null ? const NoTrainingFoundWidget() : const TrainingFoundWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
