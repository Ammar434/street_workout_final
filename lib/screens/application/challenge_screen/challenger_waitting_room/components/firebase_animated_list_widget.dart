import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../models/challenge.dart';
import '../../../../../models/custom_user.dart';
import '../../../../../provider/challenge_provider.dart';
import '../../select_challenge_screen/select_challenge_screen.dart';
import '../../../../../utils/constants.dart';

class FirebaseAnimatedListWidget extends StatelessWidget {
  FirebaseAnimatedListWidget({
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
        duration: Duration(seconds: 1),
        query: FirebaseDatabase.instance.ref().child(currentUser.favoriteParc),
        itemBuilder: (context, snapshot, animation, index) {
          final Challenge challenge = Challenge.challengeFromSnapshot(
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>),
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 0),
              end: Offset(0, 0),
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
                style: TextStyle(
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
