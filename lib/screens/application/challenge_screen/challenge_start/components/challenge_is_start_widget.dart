import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class ChallengeIsStartWidget extends StatelessWidget {
  const ChallengeIsStartWidget({
    Key? key,
    required this.customUser,
    required this.isEvaluatorFound,
    required this.listChallenge,
  }) : super(key: key);

  final CustomUser customUser;
  final List<Challenge> listChallenge;
  final bool isEvaluatorFound;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(kRadiusValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusValue),
        color: tertiaryColor.withOpacity(0.15),
      ),
      key: const Key('2'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: kPaddingValue,
          ),
          const Text(
            "Finding people arround you",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const HorizontalLine(),
          isEvaluatorFound
              ? const Expanded(
                  child: Center(
                    child: Text(
                      "No person arround found please make sure someone is arround",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    color: Colors.red,
                    child: FirebaseAnimatedList(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      query: FirebaseDatabase.instance.ref().child(customUser.favoriteParc),
                      itemBuilder: (context, snapshot, animation, index) {
                        final Challenge challenge = Challenge.challengeFromSnapshot(Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>));
                        return SlideTransition(
                          position: Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 1)).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.bounceOut,
                              reverseCurve: Curves.bounceIn,
                            ),
                          ),
                          child: ListTile(
                            title: Text(challenge.evaluatorUid),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          // : Expanded(
          //     child: ListView.builder(
          //       itemCount: listChallenge.length,
          //       itemBuilder: (context, index) => ListTile(
          //         // leading: CircleAvatar(backgroundImage: NetworkImage(listChallenge[index].challenger!.profileImage)),
          //         title: Text(listChallenge[index].evaluatorUid),
          //         trailing: const FaIcon(FontAwesomeIcons.chevronRight),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
