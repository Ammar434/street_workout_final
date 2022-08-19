import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/text_style.dart';
import '../../../services/authentication/authentication_method.dart';
import 'permission_handler_screen.dart';
import '../../../utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/slider_widget.dart';

class UserPersonalDataScreen extends StatefulWidget {
  const UserPersonalDataScreen({Key? key}) : super(key: key);
  static String name = "UserPersonalDataScreen";

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
            padding: EdgeInsets.all(kPaddingValue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.asset(
                    "assets/images/authentication/image3_authentication.png",
                  ),
                ),
                SizedBox(
                  height: kPaddingValue * 2,
                ),
                buildMiddle(context),
                RoundedButton(
                  onTap: () {
                    temporaryAgeValue = sliderAgeValue;
                    temporaryHeightValue = sliderHeightValue;
                    temporaryWeightValue = sliderWeightValue;
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
        SizedBox(
          height: kPaddingValue,
        ),
        buildColumnSlider(),
        SizedBox(
          height: kPaddingValue,
        ),
        buildColumnForDefault(context),
      ],
    );
  }

  Column buildColumnText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Tell us about yourself",
          style: kTextStyleImportance3,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        Text(
          "We'd like the following information to provide more accurate results, such as your final score in a tournament",
          style: kTextStyleHintTextImportance3,
          textAlign: TextAlign.center,
        ),
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

  Column buildColumnForDefault(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            "Use default",
            style: kTextStyleHintTextImportance4,
          ),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
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
          controlAffinity: ListTileControlAffinity.platform, //  <-- leading Checkbox
        ),
        Text(
          "If you don't wish to enter your personal information, select the default option and we will use a default value to perform these calculations.",
          style: kTextStyleHintTextImportance5,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
      ],
    );
  }
}
