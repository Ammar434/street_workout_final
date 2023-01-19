import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/custom_user.dart';
import '../../../../models/rewards.dart';
import '../../../../provider/user_provider.dart';
import 'custom_dialog_body_widget.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

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
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    bool isAchievementComplete = currentUser.rewards.contains(rewards.id);
    return GestureDetector(
      onTap: () {
        const CustomDialogBodyWidget();
      },
      child: Container(
        padding: EdgeInsets.all(kPaddingValue / 2),
        margin: EdgeInsets.symmetric(vertical: kPaddingValue / 2),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusValue),
          color: const Color(0xff181A1E),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  rewards.subtitle,
                  style: const TextStyle(
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            isAchievementComplete
                ? FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: kDefaultIconAppBarSize,
                    color: primaryColor,
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
