import 'package:flutter/material.dart';
import "../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../display_parc_champion.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
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
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.locationDot,
                size: kDefaultIconsSize,
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              Text(
                parc.completeAddress,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        SizedBox(
          height: kPaddingValue * 2,
        ),
        Text(
          "About this parc",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        ParcInfoEquipmentAvailableRow(
          list: parc.materialAvailable,
        ),
        SizedBox(
          height: kPaddingValue * 2,
        ),
        const HorizontalLine(),
        DisplayParcChampion(champion: champion),
        const HorizontalLine(),
      ],
    );
  }
}
