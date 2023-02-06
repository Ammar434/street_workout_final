import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
import '../../profile_screen/profile_screen.dart';
import 'parc_info_equipment_available.dart';
import 'parc_main_photo.dart';

class ParcInfoTopPart extends StatelessWidget {
  const ParcInfoTopPart({
    Key? key,
    required this.parc,
    required this.champion,
  }) : super(key: key);

  final Parc parc;
  final CustomUser champion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ParcMainPhoto(parc: parc),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          parc.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.locationDot,
              color: Theme.of(context).colorScheme.secondary,
              size: kDefaultIconsSize / 1.5,
            ),
            SizedBox(
              width: kSmallPaddingValue,
            ),
            Text(
              parc.completeAddress,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        const Text(
          "About this parc",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        ParcInfoEquipmentAvailableRow(
          list: parc.materialAvailable,
        ),
        const HorizontalLine(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const FaIcon(
                FontAwesomeIcons.trophy,
                size: 25,
                color: Colors.yellow,
              ),
            ),
            SizedBox(
              width: kPaddingValue,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userUid: champion.uid,
                    userProvided: champion,
                  ),
                ),
              ),
              child: Column(
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
                  Text(
                    champion.userName == "unknown" ? "No champion yet" : champion.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const HorizontalLine(),
      ],
    );
  }
}
