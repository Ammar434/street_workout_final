// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:street_workout_final/provider/challenge_provider.dart';

// import '../../../../../../utils/colors.dart';
// import '../../../../../../utils/constants.dart';
// import '../../../../../../widgets/app_bar.dart';
// import 'challenge_is_start_widget.dart';

// class ChallengerWaittingRoomBody extends StatefulWidget {
//   const ChallengerWaittingRoomBody({Key? key}) : super(key: key);
//   @override
//   State<ChallengerWaittingRoomBody> createState() => _ChallengerWaittingRoomBodyState();
// }

// class _ChallengerWaittingRoomBodyState extends State<ChallengerWaittingRoomBody> with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late ChallengeProvider challengeProvider;

//   int searchingDurationSecond = 3;
//   bool flag = true;
//   late Future t;

//   @override
//   void initState() {
//     super.initState();
//     challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
//     animationController = AnimationController(vsync: this);
//     t = Future.delayed(
//       Duration(
//         seconds: searchingDurationSecond,
//       ),
//     ).whenComplete(
//       () async {
//         animationController.stop();
//         await challengeProvider.deleteRoom(true);

//         setState(
//           () {
//             flag = !flag;
//             Future.delayed(const Duration(seconds: 5)).whenComplete(
//               () => Navigator.of(context).pop(),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     animationController.stop();
//     animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context, ""),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Lottie.network(
//               "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json",
//               controller: animationController,
//               onLoaded: (composition) {
//                 animationController.duration = composition.duration;
//                 animationController.repeat();
//               },
//             ),
//           ),
//           Expanded(
//             child: AnimatedSwitcher(
//               transitionBuilder: (Widget child, Animation<double> animation) {
//                 return ScaleTransition(scale: animation, child: child);
//               },
//               duration: const Duration(seconds: 1),
//               child: _renderWidget(),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text(
//               "Stop",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: kDefaultTitleSize * 0.75,
//                 color: primaryColor,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: kPaddingValue,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _renderWidget() {
//     if (flag) {
//       return const ChallengeIsStartWidget();
//     } else {
//       return Text(
//         "No evaluator arround you for the moment. Please retry or send us your video",
//         textAlign: TextAlign.center,
//         key: const Key("2"),
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: kDefaultTitleSize * 0.75,
//         ),
//       );
//     }
//   }
// }
