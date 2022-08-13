import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/achievement_screen/components/custom_dialog_body_widget.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class CustomTileForAchievement extends StatelessWidget {
  CustomTileForAchievement({
    Key? key,
    required this.rewards,
    required this.height,
  }) : super(key: key);

  final Reward rewards;
  final double height;
  // final
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    bool isAchievementComplete = currentUser.rewards.contains(rewards.id);
    return GestureDetector(
      onTap: () {
        CustomDialogBodyWidget();
      },
      child: Container(
        padding: EdgeInsets.all(kPaddingValue / 2),
        margin: EdgeInsets.symmetric(vertical: kPaddingValue / 2),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: Color(0xff181A1E),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.drag_indicator_rounded),
                SizedBox(
                  width: kSmallPaddingValue,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    rewards.imageUrl,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: kSmallPaddingValue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rewards.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  rewards.subtitle,
                  style: TextStyle(
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Spacer(),
            isAchievementComplete
                ? FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: kDefaultIconAppBar,
                    color: primaryColor,
                  )
                : FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: kDefaultIconAppBar,
                  ),
          ],
        ),
      ),
    );
  }
}
