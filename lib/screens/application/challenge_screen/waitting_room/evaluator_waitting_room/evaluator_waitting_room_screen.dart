import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/waitting_room/evaluator_waitting_room/components/evaluator_waitting_room_body.dart';
import 'package:street_workout_final/screens/application/challenge_screen/waitting_room/global_waitting_room/global_waitting_room_screen.dart';

class EvaluatorWaittingRoomScreen extends StatelessWidget {
  const EvaluatorWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "EvaluatorWaittingRoomScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengeProvider>(
      builder: (context, model, child) {
        debugPrint("inse ${model.getChallenge.parcId}");
        debugPrint("inse ${model.getChallenge.evaluatorUid}");

        if (model.getChallenge.challengerUid == "") {
          return const EvaluatorWaittingRoomScreenBody();
        }
        return const GlobalWaittingRoomScreen(isChallenger: false);
      },
    );
  }
}
