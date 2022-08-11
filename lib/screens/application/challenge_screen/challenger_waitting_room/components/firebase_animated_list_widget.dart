import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/select_challenge_screen/select_challenge_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

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
        query: FirebaseDatabase.instance.ref().child(currentUser.favoriteParc),
        itemBuilder: (context, snapshot, animation, index) {
          final Challenge challenge = Challenge.challengeFromSnapshot(
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>),
          );
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
              trailing: const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: kDefaultIconAppBar,
              ),
              onTap: () async {
                await challengeProvider
                    .writeChallengerUidToRealtimeDatabase(
                      currentUserAsChallenger: currentUser,
                      evaluatorReference: challenge.evaluatorUid,
                    )
                    .then((value) => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectChallengeScreen(
                              evaluatorId: challenge.evaluatorUid,
                            ))));

                // if (!mounted) return;
                // if (res == "success") {
                //   // ignore: use_build_context_synchronously
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: ((context) => GlobalWaittingRoomScreen(
                //             parcReference: currentUser.favoriteParc,
                //             userReference: challenge.evaluatorUid,
                //           )),
                //     ),
                //   );
                // }
              },
            ),
          );
        },
      ),
    );
  }
}
