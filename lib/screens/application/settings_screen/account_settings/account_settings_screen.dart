import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/screens/application/settings_screen/account_settings/components/user_personal_information_settings_screen.dart';
import 'package:street_workout_final/services/firestore_methods/user_firestore_methods.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/slider_widget.dart';
import 'package:street_workout_final/widgets/snackbar.dart';

import 'components/gender_setting_screen.dart';
import 'components/profile_image_update_setting_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({
    Key? key,
    required this.customUser,
  }) : super(key: key);
  static String name = "AccountSettingsScreen";
  final CustomUser customUser;
  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late CustomUser customUser;

  void onTap() async {
    setState(() {
      isLoading = true;
    });

    String res = await UserFirestoreMethods().updateUserData(
      age: sliderAgeValue.toInt(),
      height: sliderHeightValue,
      weight: sliderWeightValue,
      gender: isMale,
    );

    setState(() {
      isLoading = false;
    });
    if (res == "success") {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Success",
        content: "Your update has been taken",
        contentType: ContentType.success,
      );
    } else {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Error",
        content: "Please retry",
        contentType: ContentType.failure,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    customUser = widget.customUser;
    sliderAgeValue = customUser.age.toDouble();
    sliderWeightValue = customUser.weight;
    sliderHeightValue = customUser.height;
    isMale = customUser.gender == "male";
  }

  bool isLoading = false;

  double ageMin = 14;
  double ageMax = 80;
  double weightMin = 0;
  double weightMax = 150;
  double heightMin = 90;
  double heightMax = 240;
  double sliderAgeValue = 21;
  double sliderWeightValue = 23;
  double sliderHeightValue = 34;
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(context, "Account settings"),
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileImageUpdateSettingScreen(customUser: customUser),
                  UserPersonalInformationSettingsScreen(
                    child: buildColumnSlider(),
                  ),
                  GenderSettingsScreen(
                    onTap: () {
                      setState(() {
                        isMale = !isMale;
                      });
                    },
                    isMale: isMale,
                  ),
                  RoundedButton(
                    isLoading: isLoading,
                    onTap: onTap,
                    text: "Update",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
              sliderHeightValue = v;
            });
          },
          sliderUnits: 'cm',
        ),
      ],
    );
  }
}
