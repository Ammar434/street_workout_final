import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/profile_screen/components/user_information_display.dart';
import 'package:street_workout_final/screens/application/profile_screen/components/user_tab_display.dart';
import 'package:street_workout_final/utils/constants.dart';

class UserProfileBodyWidget extends StatelessWidget {
  const UserProfileBodyWidget({
    Key? key,
    required this.name,
    required this.favoriteParc,
    required this.userContribution,
    required this.userTrainingPoint,
    required this.userEvaluation,
    required this.listUrlImage,
  }) : super(key: key);
  final String name;
  final String favoriteParc;
  final int userContribution;
  final int userTrainingPoint;
  final int userEvaluation;
  final List<String> listUrlImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kPaddingValue,
        left: kSmallPaddingValue,
        right: kSmallPaddingValue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInformationDisplay(
            name: name,
            favoriteParc: favoriteParc,
            userContribution: userContribution,
            userTrainingPoint: userTrainingPoint,
            userEvaluation: userEvaluation,
          ),
          const SizedBox(
            height: kPaddingValue,
          ),
          UserTabDisplay(
            listUrlImage: listUrlImage,
          ),
        ],
      ),
    );
  }
}
