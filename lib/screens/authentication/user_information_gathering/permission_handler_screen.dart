import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:street_workout_final/screens/application/main_screen.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';

class PermissionHandlerScreen extends StatelessWidget {
  const PermissionHandlerScreen({Key? key}) : super(key: key);
  static const String name = "PermissionHandlerScreen";

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
                  "assets/images/authentication/image1_authentication.png",
                ),
              ),
              buildMiddle(context),
              RoundedButton(
                onTap: () async {
                  await Permission.location.shouldShowRequestRationale;
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.name, (route) => false);
                  // var status = await Permission.location.status;
                  //
                  // if (await Permission.speech.isPermanentlyDenied) {
                  //   // The user opted to never again see the permission request dialog for this
                  //   // app. The only way to change the permission's status now is to let the
                  //   // user manually enable it in the system settings.
                  //   openAppSettings();
                  // }
                  // if (await Permission.location.request().isGranted) {
                  //   Navigator.pushNamed(context, GenderScreen.name);
                  // }
                },
                text: "Complete",
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
        const Text(
          "Location",
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
          "Allow access to your location so we can accurately track your trainings via GPS signal",
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
