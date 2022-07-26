import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_circle_user_profile_widget.dart';

class TileLeaderboardRow extends StatelessWidget {
  const TileLeaderboardRow({
    Key? key,
    required this.index,
    this.gradient,
    required this.userScore,
  }) : super(key: key);
  final int index;
  final int userScore;
  final LinearGradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPaddingValue),
      child: Row(
        children: [
          Text(
            index.toString(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: kPaddingValue,
          ),
          RoundedCircleUserProfileWidget(
            gradient: gradient,
            radius: kRadiusValue * 2.5,
          ),
          const SizedBox(
            width: kPaddingValue,
          ),
          SizedBox(
            width: 100,
            child: Text(
              Faker.instance.name.fullName(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Text(
            userScore.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
