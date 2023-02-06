import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/screens/application/profile_screen/profile_screen.dart';

import '../../../common_libs.dart';

class DisplayParcChampion extends StatelessWidget {
  const DisplayParcChampion({
    super.key,
    required this.champion,
  });

  final CustomUser champion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPaddingValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            maxRadius: 25,
            child: const FaIcon(
              FontAwesomeIcons.trophy,
              size: 25,
            ),
          ),
          SizedBox(
            width: kPaddingValue * 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Current Champion",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              GestureDetector(
                onTap: () {
                  if (champion.userName != "unknown") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userUid: champion.uid,
                          userProvided: champion,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  champion.userName == "unknown" ? "No champion yet" : champion.userName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
