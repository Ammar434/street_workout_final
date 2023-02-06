import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/challenge.dart';
import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/challenge_provider.dart';
import '../../global_waitting_room/global_waitting_room_screen.dart';

class FirebaseAnimatedListWidget extends StatelessWidget {
  const FirebaseAnimatedListWidget({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final CustomUser currentUser;

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context, listen: true);
    return Expanded(
      child: FirebaseAnimatedList(
        padding: EdgeInsets.zero,
        duration: const Duration(seconds: 1),
        query: challengeProvider.listenToEvaluatorJoinParc(),
        itemBuilder: (context, snapshot, animation, index) {
          final Challenge challenge = Challenge.challengeFromSnapshot(
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>),
          );
          if (challenge.challengerUid.isEmpty && challenge.isChallengeEndChallenger == false && challenge.isChallengeEndEvaluator == false) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.bounceOut,
                  reverseCurve: Curves.bounceIn,
                ),
              ),
              child: ListTile(
                title: Text(challenge.evaluatorName),
                subtitle: Text(
                  challenge.evaluatorUid,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    challenge.evaluatorImageUrl,
                  ),
                ),
                trailing: FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: kDefaultIconAppBarSize,
                ),
                onTap: () async {
                  await challengeProvider.addEvaluatorToChallenge(challenge).then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const GlobalWaittingRoomScreen(
                              isChallenger: true,
                            ),
                          ),
                        ),
                      );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
