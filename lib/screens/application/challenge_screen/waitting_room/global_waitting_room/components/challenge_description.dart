import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../models/rewards.dart';
import '../../../../../../services/firestore_methods/rewards_firestore_methods.dart';
import '../../../../../../widgets/loading_widget.dart';

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({Key? key, required this.rewardId, required this.isChallenger}) : super(key: key);
  final String rewardId;
  final bool isChallenger;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RewardsFirestoreMethods().getRewardsById(rewardId),
      builder: (context, AsyncSnapshot<Reward> snapshot) {
        if (snapshot.hasData) {
          List<dynamic> instructions = snapshot.data!.description;
          return SizedBox(
            height: 200.sp,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'What you have to do:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  ...List.generate(
                    instructions.length,
                    (index) => ListTile(
                      leading: const FaIcon(FontAwesomeIcons.solidCircle),
                      title: Text(instructions[index]),
                    ),
                  ),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                ],
              ),
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }
}
