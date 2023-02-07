import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../models/custom_user.dart';
import 'components/user_information_display.dart';

class ProfileScreenBodyTop extends StatelessWidget {
  const ProfileScreenBodyTop({
    Key? key,
    required this.user,
  }) : super(key: key);

  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(
            height: 200.sp,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user.profileImage,
              ),
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          UserInformationDisplay(
            name: user.userName,
            favoriteParc: "",
            userContribution: user.numberOfContribution,
            userTrainingPoint: user.points,
            userEvaluation: user.numberOfEvaluation,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
        ],
      ),
    );
  }
}
