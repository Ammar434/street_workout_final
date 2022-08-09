import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/rewards.dart';
import 'package:street_workout_final/utils/constants.dart';

class CustomTileForSelectChallenge extends StatelessWidget {
  const CustomTileForSelectChallenge({
    Key? key,
    required this.rewards,
    required this.onTap,
  }) : super(key: key);

  final Reward rewards;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kPaddingValue / 2),
        margin: const EdgeInsets.symmetric(vertical: kPaddingValue / 2),
        height: 85,
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
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: kDefaultIconAppBar,
            ),
            const SizedBox(
              width: kSmallPaddingValue,
            ),
          ],
        ),
      ),
    );
  }
}
