import 'package:flutter/material.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../widgets/loading_widget.dart';
import 'gender_screen.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String name = "WelcomeScreen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late String userName;
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    userName = await AuthenticationMethod().getUserNameFromSecureStorage() ??
        "UNKNOWN";
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: isLoading
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(kPaddingValue),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2.5,
                      child: Image.asset(
                        "assets/images/authentication/image1_authentication.png",
                      ),
                    ),
                    buildMiddle(context),
                    RoundedButton(
                      onTap: () {
                        Navigator.pushNamed(context, GenderScreen.name);
                      },
                      text: "Get started",
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Column buildMiddle(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome $userName, you're in!",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "To make sure your experience with Street Workout Fighter is the best it can be, we'd like to get to know you a little better.",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
