import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/screens/application/challenge_screen/global_waitting_room/global_waitting_room_screen.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';
import 'package:street_workout_final/utils/constants.dart';

class FirebaseAnimatedListWidget extends StatelessWidget {
  const FirebaseAnimatedListWidget({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final CustomUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        physics: const NeverScrollableScrollPhysics(),
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
              title: Text(challenge.evaluatorUid),
              trailing: const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: kDefaultIconAppBar,
              ),
              onTap: () async {
                String res = await RealtimeDatabaseMethods().addChallengerToChallenge(
                  parcId: currentUser.favoriteParc,
                  evaluatorUid: challenge.evaluatorUid,
                  challengerUid: currentUser.uid,
                );
                if (res == "success") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GlobalWaittingRoomScreen()));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
