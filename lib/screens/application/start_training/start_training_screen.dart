import 'package:flutter/material.dart';

class StartTrainingScreen extends StatelessWidget {
  StartTrainingScreen({Key? key}) : super(key: key);
  static String name = "StartTrainingScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("We will develod this screen soon"),
          ],
        ),
      ),
    );
  }
}
