import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/theme.dart';
import 'package:street_workout_final/widgets/app_bar.dart';

import '../../../utils/colors.dart';

final List<String> _listRewardCatgory = [
  "Mental",
  "Others",
  "Social",
  "Strengh",
];

class AddNewAchievement extends StatefulWidget {
  const AddNewAchievement({Key? key}) : super(key: key);
  static String name = "AddNewAchievement";

  @override
  State<AddNewAchievement> createState() => AddNewAchievementState();
}

class AddNewAchievementState extends State<AddNewAchievement> {
  int currentStep = 0;
  String selectedReward = _listRewardCatgory[0];
  String rewardName = "";
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: Scaffold(
        appBar: buildAppBar(context, "Add reward"),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stepper(
              currentStep: currentStep,
              type: StepperType.horizontal,
              onStepTapped: (index) {
                setState(() => currentStep = index);
              },
              onStepContinue: () {
                if (currentStep != 3) {
                  setState(() => currentStep++);
                }
              },
              onStepCancel: () {
                if (currentStep != 0) {
                  setState(() => currentStep--);
                }
              },
              steps: [
                buildStep1()
                // buildStep1(context),
                // buildStep2(),
                // Step(
                //   isActive: currentStep >= 2,
                //   title: const Text('Add description'),
                //   content: Padding(
                //     padding: const EdgeInsets.only(top: 20),
                //     child: Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: TextField(
                //               controller: _todoController,
                //               decoration: const InputDecoration(
                //                 hintText: 'Add a new todo item',
                //                 border: InputBorder.none,
                //               ),
                //             ),
                //           ),
                //           Container(
                //             margin: const EdgeInsets.only(
                //               bottom: 20,
                //               right: 20,
                //             ),
                //             child: ElevatedButton(
                //               onPressed: () {
                //                 // _addToDoItem(_todoController.text);
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 backgroundColor: primaryColor,
                //                 minimumSize: const Size(60, 60),
                //                 elevation: 10,
                //               ),
                //               child: const Text(
                //                 '+',
                //                 style: TextStyle(
                //                   fontSize: 40,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Step(
                //   isActive: currentStep >= 3,
                //   title: const Text('Ajouter une image'),
                //   content: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Expanded(
                //         child: Image.asset("images/Jardinage.png"),
                //       ),
                //       Expanded(
                //         child: Image.asset("images/baby sitting.png"),
                //       ),
                //       Expanded(
                //         child: Image.asset("images/Coiffure.png"),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Step buildStep2() {
    return Step(
      isActive: currentStep >= 1,
      title: const Text("Choose reward name"),
      content: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextField(
          maxLength: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black, width: 1.5), borderRadius: BorderRadius.circular(30)),
            labelText: "Reward name",
          ),
          onChanged: (text) {
            rewardName = text;
          },
        ),
      ),
    );
  }

  Step buildStep1() {
    return Step(
      isActive: currentStep >= 0,
      title: const Text('Select reward category'),
      content: DefaultTextStyle(
        style: const TextStyle(
          color: primaryColor,
          fontSize: 22.0,
        ),
        child: Column(
          children: List.generate(
            _listRewardCatgory.length,
            (index) {
              return RadioListTile(
                title: Text(_listRewardCatgory[index]),
                value: _listRewardCatgory[index],
                groupValue: selectedReward,
                activeColor: primaryColor,
                onChanged: (value) {
                  setState(() {
                    selectedReward = value.toString();
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
