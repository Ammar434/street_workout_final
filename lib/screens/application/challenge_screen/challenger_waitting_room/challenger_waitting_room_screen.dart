import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenger_waitting_room/components/challenger_waitting_room_body.dart';
import 'package:street_workout_final/screens/application/challenge_screen/global_waitting_room/global_waitting_room_screen.dart';
import 'package:street_workout_final/screens/application/challenge_screen/select_challenge_screen/select_challenge_screen.dart';

// class ChallengerWaittinRoomScreen extends StatefulWidget {
//     ChallengerWaittinRoomScreen({Key? key}) : super(key: key);
//   static String name = "ChallengerWaittinRoomScreen";

//   @override
//   State<ChallengerWaittinRoomScreen> createState() => _ChallengerWaittinRoomScreenState();
// }

// class _ChallengerWaittinRoomScreenState extends State<ChallengerWaittinRoomScreen> {
//   @override
//   Widget build(BuildContext context) {
//     bool isRoomEmpty = Provider.of<ChallengeProvider>(context).isRoomEmpty;
//     CustomUser customUser = Provider.of<UserProvider>(context).getUser;

//     if (isRoomEmpty) {
//       return   ChallengerWaittingRoomBody();
//     }
//     return   SelectChallengeScreen();
//     // return   GlobalWaittingRoomScreen();
//   }
// }

class ChallengerWaittinRoomScreen extends StatelessWidget {
  ChallengerWaittinRoomScreen({Key? key}) : super(key: key);
  static String name = "ChallengerWaittinRoomScreen";

  @override
  Widget build(BuildContext context) {
    bool isRoomEmpty = Provider.of<ChallengeProvider>(context).isRoomEmpty;
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    if (isRoomEmpty) {
      return ChallengerWaittingRoomBody();
    }
    // return   SelectChallengeScreen();
    return GlobalWaittingRoomScreen();
  }
}
