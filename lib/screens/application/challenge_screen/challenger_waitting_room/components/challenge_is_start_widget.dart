import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

import 'firebase_animated_list_widget.dart';

class ChallengeIsStartWidget extends StatelessWidget {
  const ChallengeIsStartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    return Container(
      key: const Key("1"),
      margin: const EdgeInsets.all(kRadiusValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusValue),
        color: tertiaryColor.withOpacity(0.15),
      ),
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
