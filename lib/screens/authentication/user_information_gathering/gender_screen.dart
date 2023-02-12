import 'package:flutter/material.dart';
import "../../../common_libs.dart";

import '../../../services/authentication/authentication_method.dart';
import '../../../widgets/rounded_button.dart';
import 'user_personal_data_screen.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);
  static String name = "GenderScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(child: SizedBox()),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  "assets/images/authentication/image2_authentication.png",
                ),
              ),
              Column(
                children: [
                  Text(
                    "Select your gender",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  RoundedButton(
                    onTap: () {
                      temporaryGender = "male";
                      Navigator.pushNamed(context, UserPersonalDataScreen.name);
                    },
                    text: "Male",
                  ),
                  RoundedButton(
                    onTap: () {
                      temporaryGender = "female";
                      Navigator.pushNamed(context, UserPersonalDataScreen.name);
                    },
                    text: "Female",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
