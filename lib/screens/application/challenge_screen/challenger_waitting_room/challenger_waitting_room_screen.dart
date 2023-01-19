import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/challenge_provider.dart';
import 'components/challenger_waitting_room_body.dart';
import '../global_waitting_room/global_waitting_room_screen.dart';

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
  const ChallengerWaittinRoomScreen({Key? key}) : super(key: key);
  static String name = "ChallengerWaittinRoomScreen";

  @override
  Widget build(BuildContext context) {
    bool isRoomEmpty = Provider.of<ChallengeProvider>(context).isRoomEmpty;
    // CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    if (isRoomEmpty) {
      return const ChallengerWaittingRoomBody();
    }
    // return   SelectChallengeScreen();
    return const GlobalWaittingRoomScreen();
  }
}
