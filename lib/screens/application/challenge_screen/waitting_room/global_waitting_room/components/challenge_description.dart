import 'package:flutter/material.dart';
import "../../../../../../common_libs.dart";
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
                  Text(
                    'What you have to do:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: kPaddingValue,
                  ),
                  ...List.generate(
                    instructions.length,
                    (index) => ListTile(
                      leading: const Icon(Icons.circle_rounded),
                      title: Text(
                        instructions[index],
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
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
