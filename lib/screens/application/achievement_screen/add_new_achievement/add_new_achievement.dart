import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'components/list_tile_for_instruction.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/rounded_button.dart';

import '../../../../services/firestore_methods/rewards_firestore_methods.dart';
import 'components/selectable_image.dart';

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
  String toAddInstruction = "";
  int tileIndex = 0;
  int totalImage = 67;
  int _selectedImageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _todoController = TextEditingController();
  final key = GlobalKey<AnimatedListState>();
  List<String> listInstruction = [];

  void insertItem(String text) {
    if (text.isNotEmpty) {
      listInstruction.add(text);
      key.currentState!.insertItem(0);
    }
  }

  void removeItem(int index) {
    final removedItem = listInstruction[index];
    listInstruction.removeAt(index);
    key.currentState!.removeItem(
      index,
      (context, animation) => ListTileForInstruction(
        item: removedItem,
        animation: animation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Add reward"),
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.vertical,
        onStepTapped: (index) {
          // setState(() => currentStep = index);
        },
        onStepContinue: () async {
          if (currentStep == 0) {
            setState(() => currentStep++);
          }
          if (currentStep == 1 && rewardName != "") {
            setState(() => currentStep++);
          }
          if (currentStep == 2 && listInstruction.isNotEmpty) {
            setState(() => currentStep++);
          }

          if (currentStep == 3) {
            String path = "assets/images/achievements/asset_$_selectedImageIndex.png";

            String res = await RewardsFirestoreMethods().addRewards(
              rewardName,
              selectedReward,
              path,
              listInstruction,
            );

            if (res == "Success") {
              customShowSnackBar(
                globalKey: _scaffoldKey,
                title: "Success",
                content: "You submited your reward we will analyse it quickly and publish ASAP",
                contentType: ContentType.success,
              );
              if (!mounted) return;
              Navigator.pop(context);
            }
          }
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          }
        },
        steps: [
          buildStep1(),
          buildStep2(),
          buildStep3(),
          buildStep4(),
        ],
      ),
    );
  }

  Step buildStep4() {
    return Step(
      isActive: currentStep >= 3,
      title: const Text('Ajouter une image'),
      content: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        shrinkWrap: true,
        children: [
          for (int index = 0; index < totalImage; index++)
            SelectableImage(
              isSelected: _selectedImageIndex == index,
              imageAsset: "assets/images/achievements/asset_$index.png",
              onTap: (selectedImageIndex) {
                setState(() {
                  _selectedImageIndex = index;
                });
              },
            ),
        ],
      ),
    );
  }

  Step buildStep3() {
    return Step(
      isActive: currentStep >= 2,
      title: const Text("Add instructions"),
      content: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    maxLength: 30,
                    controller: _todoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusValue),
                      ),
                    ),
                    onChanged: (text) {
                      toAddInstruction = text;
                    },
                  ),
                ),
                Expanded(
                  child: RoundedButton(
                    onTap: () {
                      insertItem(_todoController.text);
                      _todoController.clear();
                    },
                    text: "Add",
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: AnimatedList(
              key: key,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              initialItemCount: listInstruction.length,
              itemBuilder: (context, index, animation) => ListTileForInstruction(
                item: listInstruction[index],
                animation: animation,
                onClicked: () => removeItem(index),
              ),
            ),
          )
        ],
      ),
    );
  }

  Step buildStep2() {
    return Step(
      isActive: currentStep >= 1,
      title: const Text("Choose reward name"),
      content: TextField(
        maxLength: 30,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadiusValue),
          ),
        ),
        onChanged: (text) {
          rewardName = text;
        },
      ),
    );
  }

  Step buildStep1() {
    return Step(
      isActive: currentStep >= 0,
      title: const Text('Select reward category'),
      content: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
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
                activeColor: Theme.of(context).colorScheme.secondary,
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
