import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/screens/application/profile_screen/components/user_information_display.dart';
import 'package:street_workout_final/utils/constants.dart';

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
          Container(
            width: double.infinity,
            height: 250.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user.profileImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          UserInformationDisplay(
            name: user.userName,
            favoriteParc: user.favoriteParc == "" ? "The user's favorite park has not been filled in" : user.favoriteParc,
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
