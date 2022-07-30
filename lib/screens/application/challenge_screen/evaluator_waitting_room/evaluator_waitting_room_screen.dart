import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/global_waitting_room/global_waitting_room_screen.dart';

import 'components/evaluator_waitting_room_body.dart';

class EvaluatorWaittingRoomScreen extends StatefulWidget {
  const EvaluatorWaittingRoomScreen({Key? key}) : super(key: key);
  static String name = "EvaluatorWaittingRoomScreen";

  @override
  State<EvaluatorWaittingRoomScreen> createState() => _EvaluatorWaittingRoomScreenState();
}

class _EvaluatorWaittingRoomScreenState extends State<EvaluatorWaittingRoomScreen> {
  late CustomUser _customUser;
  late ChallengeProvider challengeProvider;

  @override
  void dispose() {
    challengeProvider.deleteRoom(_customUser);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isRoomEmpty = Provider.of<ChallengeProvider>(context, listen: true).isRoomEmpty;
    _customUser = Provider.of<UserProvider>(context).getUser;
    challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);

    if (isRoomEmpty) return const EvaluatorWaittingRoomScreenBody();
    return GlobalWaittingRoomScreen(
      userReference: _customUser.uid,
      parcReference: _customUser.favoriteParc,
    );
  }
}
