import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/permission_handler_screen.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/slider_widget.dart';

class UserPersonalDataScreen extends StatefulWidget {
  const UserPersonalDataScreen({Key? key}) : super(key: key);
  static const String name = "UserPersonalDataScreen";

  @override
  State<UserPersonalDataScreen> createState() => _UserPersonalDataScreenState();
}

class _UserPersonalDataScreenState extends State<UserPersonalDataScreen> {
  bool checkedValue = false;
  double ageMin = 14;
  double ageMax = 80;
  double weightMin = 0;
  double weightMax = 150;
  double heightMin = 90;
  double heightMax = 240;
  double sliderAgeValue = 21;
  double sliderWeightValue = 76;
  double sliderHeightValue = 176;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingValue),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2.5,
                  child: Image.asset(
                    "assets/images/authentication/image3_authentication.png",
                  ),
                ),
                buildMiddle(context),
                RoundedButton(
                  onTap: () {
                    Navigator.pushNamed(context, PermissionHandlerScreen.name);
                  },
                  text: "Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildMiddle(BuildContext context) {
    return Column(
      children: [
        buildColumnText(context),
        buildColumnSlider(),
        buildColumnForDefault(context),
      ],
    );
  }

  Column buildColumnSlider() {
    return Column(
      children: [
        SliderWidget(
          max: ageMax,
          min: ageMin,
          sliderDefaultValue: sliderAgeValue,
          sliderName: "Age",
          onDrag: (v) {
            setState(() {
              checkedValue = false;
              sliderAgeValue = v;
            });
          },
          sliderUnits: 'year',
        ),
        SliderWidget(
          max: weightMax,
          min: weightMin,
          sliderDefaultValue: sliderWeightValue,
          sliderName: "Weight",
          onDrag: (v) {
            setState(() {
              checkedValue = false;
              sliderWeightValue = v;
            });
          },
          sliderUnits: 'kg',
        ),
        SliderWidget(
          max: heightMax,
          min: heightMin,
          sliderDefaultValue: sliderHeightValue,
          sliderName: "Height",
          onDrag: (v) {
            setState(() {
              checkedValue = false;
              sliderHeightValue = v;
            });
          },
          sliderUnits: 'cm',
        ),
      ],
    );
  }

  Column buildColumnText(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Tell us about yourself",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "We'd like the following information to provide more accurate results, such as your final score in a tournament",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Column buildColumnForDefault(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: CheckboxListTile(
            title: Text(
              "Use default",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            checkColor: Colors.white,
            activeColor: primaryColor,
            value: checkedValue,
            onChanged: (newValue) {
              sliderWeightValue = 76;
              sliderAgeValue = 21;
              sliderHeightValue = 176;
              setState(
                () {
                  checkedValue = newValue!;
                },
              );
            },
            controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ),
        Text(
          "If you don't wish to enter your personal information, select the default option and we will use a default value to perform these calculations.",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
