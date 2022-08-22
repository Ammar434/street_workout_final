import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/custom_user.dart';
import '../../../../models/workout.dart';
import '../../../../provider/user_provider.dart';
import 'components/app_bar_for_trainning.dart';
import 'components/date_select_builder.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_style.dart';

import 'components/cutom_button_for_trainning_screen.dart';

class StartTrainingScreen extends StatelessWidget {
  const StartTrainingScreen({Key? key}) : super(key: key);
  static String name = "StartTrainingScreen";

  @override
  Widget build(BuildContext context) {
    List<Workout> listWorkout = [];

    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

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
              listWorkout.isEmpty
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
                            onTap: () {},
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
                      itemCount: 2,
                      itemBuilder: (index, context) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: kPaddingValue),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(kRadiusValue),
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
