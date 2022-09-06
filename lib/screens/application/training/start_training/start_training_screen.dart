import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/datas/training/training_data.dart';
import 'package:street_workout_final/models/training.dart';
import 'package:street_workout_final/screens/application/training/select_training/select_trainning_screen.dart';
import 'package:street_workout_final/services/dates_services.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/user_provider.dart';
import 'components/app_bar_for_trainning.dart';
import 'components/date_select_builder.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_style.dart';

import 'components/cutom_button_for_trainning_screen.dart';

Training? trainingOfTheDay;

class StartTrainingScreen extends StatelessWidget {
  const StartTrainingScreen({Key? key}) : super(key: key);
  static String name = "StartTrainingScreen";

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    DateTime dateTime = DateTime.now();
    for (Training t in listTraining) {
      if (isSameDay(t.dateTime, dateTime)) {
        trainingOfTheDay = t;
      }
    }
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
              listTraining.isEmpty
                  ? Expanded(
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
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: trainingOfTheDay!.listWorkout.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusValue)),
                            color: tertiaryColor.withOpacity(0.1),
                            elevation: 10,
                            child: Column(
                              children: [
                                Row(
                                  children: [Text(trainingOfTheDay!.listWorkout[index].name)],
                                ),
                                const HorizontalLine(),
                                ...List.generate(
                                  trainingOfTheDay!.listWorkout[index].listSets.length,
                                  ((index2) {
                                    return Row(
                                      children: [
                                        Text("${index2 + 1} ."),
                                        SizedBox(width: kPaddingValue),
                                        Text("Weight ${trainingOfTheDay!.listWorkout[index].listSets[index2].weight}"),
                                        Text("Reps ${trainingOfTheDay!.listWorkout[index].listSets[index2].numberOfRep}"),
                                      ],
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
