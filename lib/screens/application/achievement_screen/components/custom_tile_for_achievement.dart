import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/rewards.dart';
import '../../../../provider/user_provider.dart';
import 'custom_dialog_body_widget.dart';

class CustomTileForAchievement extends StatelessWidget {
  const CustomTileForAchievement({
    Key? key,
    required this.rewards,
    required this.height,
  }) : super(key: key);

  final Reward rewards;
  final double height;
  // final
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    bool isAchievementComplete = currentUser.rewards.contains(rewards.id);
    return GestureDetector(
      onTap: () {
        if (isAchievementComplete) {
          showDialog(
            context: context,
            builder: (context) => const CustomDialogBodyWidget(),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(kPaddingValue / 2),
        margin: EdgeInsets.symmetric(vertical: kPaddingValue / 2),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.drag_indicator_rounded),
                SizedBox(
                  width: kSmallPaddingValue,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Spacer(),
            isAchievementComplete
                ? FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: kDefaultIconAppBarSize,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                : FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: kDefaultIconAppBarSize,
                  ),
          ],
        ),
      ),
    );
  }
}
