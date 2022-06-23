import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/authentication/user_information_gathering/user_personal_data_screen.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);
  static const String name = "GenderScreen";

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.pushNamed(context, UserPersonalDataScreen.name);
    }

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3 / 2.5,
                child: Image.asset(
                  "assets/images/authentication/image2_authentication.png",
                ),
              ),
              Column(
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
                    height: kPaddingValue,
                  ),
                  RoundedButton(
                    onTap: onTap,
                    text: "Male",
                  ),
                  RoundedButton(
                    onTap: onTap,
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
