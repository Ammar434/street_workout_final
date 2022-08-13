import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../models/custom_user.dart';
import '../../profile_screen/profile_screen.dart';

import '../../../../../utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

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
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
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
              const Text("By"),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: kRadiusValue,
                backgroundImage: NetworkImage(creator.profileImage),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                creator.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: primaryColor,
                child: FaIcon(
                  FontAwesomeIcons.trophy,
                  size: 25,
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Champion",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0.01,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (champion.userName != "unknown") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              userUid: creator.uid,
                              userProvided: champion,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      champion.userName == "unknown" ? "No champion yet" : champion.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
