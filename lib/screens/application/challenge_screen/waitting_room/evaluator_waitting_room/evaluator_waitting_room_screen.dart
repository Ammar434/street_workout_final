import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/challenge_provider.dart';
import '../global_waitting_room/global_waitting_room_screen.dart';
import 'components/evaluator_waitting_room_body.dart';

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
