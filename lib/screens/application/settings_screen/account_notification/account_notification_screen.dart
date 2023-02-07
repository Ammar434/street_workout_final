import 'package:flutter/material.dart';
import 'package:street_workout_final/widgets/app_bar.dart';

class AccountNotificationScreen extends StatelessWidget {
  const AccountNotificationScreen({Key? key}) : super(key: key);
  static String name = "AccountNotificationScreen";
  @override
  Widget build(BuildContext context) {
    bool isSwitch = false;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, ""),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                  value: isSwitch,
                  onChanged: (bool v) {
                    isSwitch = v;
                  },
                ),
                const FittedBox(
                    child: Text(
                  "Receive our weekly mail",
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
