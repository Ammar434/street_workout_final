import 'package:flutter/material.dart';
import '../../../services/authentication/authentication_method.dart';
import 'user_personal_data_screen.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key? key}) : super(key: key);
  static const String name = "GenderScreen";

  @override
  Widget build(BuildContext context) {
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
