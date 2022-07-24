import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
import '../../../../widgets/horizontal_line.dart';
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
        const SizedBox(
          height: kPaddingValue,
        ),
        Text(
          parc.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(
          height: kSmallPaddingValue,
        ),
        Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.locationDot,
              color: primaryColor,
              size: kDefaultIconsSize / 1.5,
            ),
            const SizedBox(
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
        const SizedBox(
          height: kPaddingValue,
        ),
        const Text(
          "About this parc",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: kSmallPaddingValue,
        ),
        ParcInfoEquipmentAvailableRow(
          list: parc.materialAvailable,
        ),
        const HorizontalLine(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: primaryColor,
              child: FaIcon(
                FontAwesomeIcons.trophy,
                size: 25,
                color: Colors.white70,
              ),
            ),
            const SizedBox(
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
                Text(
                  champion.userName == "unknown"
                      ? "No champion yet"
                      : champion.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
