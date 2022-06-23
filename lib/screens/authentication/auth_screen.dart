import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/authentication/login_screen.dart';
import 'package:street_workout_final/screens/authentication/register_screen.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

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
                  "assets/images/authentication/image0_authentication.png",
                ),
              ),
              buildMiddle(context),
              buildRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Column buildMiddle(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Europe’s #1 fitness app",
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
          "Whatever your fitness level, achieve your goals quickly and build healthy habits with our app",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.name);
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRadiusValue),
                  bottomLeft: Radius.circular(kRadiusValue),
                ),
              ),
              child: const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.name);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    kRadiusValue,
                  ),
                  bottomRight: Radius.circular(
                    kRadiusValue,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
