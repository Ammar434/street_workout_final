import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/parc_info/display_parc_champion.dart';

import '../../../../models/custom_user.dart';
import '../../profile_screen/profile_screen.dart';

class ParcDisplayCardInfo extends StatelessWidget {
  const ParcDisplayCardInfo({
    Key? key,
    required this.creator,
    required this.champion,
    required this.parcName,
  }) : super(key: key);
  final CustomUser creator;
  final CustomUser champion;
  final String parcName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            parcName,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (creator.userName != "unknown") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userUid: creator.uid,
                    userProvided: creator,
                  ),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Publish By",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              CircleAvatar(
                radius: kRadiusValue,
                backgroundImage: NetworkImage(creator.profileImage),
              ),
              SizedBox(
                width: kSmallPaddingValue,
              ),
              Text(
                creator.userName,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        DisplayParcChampion(champion: champion),
      ],
    );
  }
}
