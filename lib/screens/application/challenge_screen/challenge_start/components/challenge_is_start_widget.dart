import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

import 'firebase_animated_list_widget.dart';

class ChallengeIsStartWidget extends StatelessWidget {
  const ChallengeIsStartWidget({
    Key? key,
    // required this.currentUser,
  }) : super(key: key);

  // final CustomUser currentUser;

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    bool isRoomEmpty = Provider.of<ChallengeProvider>(context).isRoomEmpty;
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
          FirebaseAnimatedListWidget(currentUser: currentUser),
        ],
      ),
    );
  }
}
