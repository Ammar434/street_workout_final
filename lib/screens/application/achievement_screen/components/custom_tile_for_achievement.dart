import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class CustomTileForAchievement extends StatelessWidget {
  const CustomTileForAchievement({
    Key? key,
    required this.rewards,
    required this.height,
  }) : super(key: key);

  final Rewards rewards;
  final double height;
  // final
  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.all(kPaddingValue / 2),
      margin: const EdgeInsets.symmetric(vertical: kPaddingValue / 2),
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
              const SizedBox(
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
          const SizedBox(
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
          currentUser.rewards.contains(rewards.id)
              ? const FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  size: kDefaultIconAppBar,
                  color: primaryColor,
                )
              : const FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: kDefaultIconAppBar,
                ),
        ],
      ),
    );
  }
}
