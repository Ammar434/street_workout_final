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
  ParcInfoTopPart({
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.locationDot,
              color: primaryColor,
              size: kDefaultIconsSize / 1.5,
            ),
            SizedBox(
              width: kSmallPaddingValue,
            ),
            Text(
              parc.completeAddress,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
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
        HorizontalLine(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
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
                Text(
                  "Current Champion",
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.01,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  champion.userName == "unknown" ? "No champion yet" : champion.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
