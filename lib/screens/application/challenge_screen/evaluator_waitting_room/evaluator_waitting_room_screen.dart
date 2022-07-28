import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/global_waitting_room/global_waitting_room_screen.dart';

import 'components/evaluator_waitting_room_body.dart';

class EvaluatorWaittingRoomScreen extends StatelessWidget {
  const EvaluatorWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "EvaluatorWaittingRoomScreen";

  @override
  Widget build(BuildContext context) {
    bool isRoomEmpty = Provider.of<ChallengeProvider>(context).isRoomEmpty;

    if (isRoomEmpty) {
      return const EvaluatorWaittingRoomScreenBody();
    }
    return const GlobalWaittingRoomScreen();
  }
}
