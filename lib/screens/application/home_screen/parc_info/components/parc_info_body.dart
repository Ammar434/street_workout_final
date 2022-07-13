import 'package:flutter/material.dart';
import '../../home/components/parc_display_card.dart';

import '../../../../../utils/constants.dart';

import 'parc_info_equipment_available.dart';
import 'parc_info_tab_display.dart';

class ParcInfoBodyWidget extends StatelessWidget {
  const ParcInfoBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingValue, left: kPaddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ParcDisplayCardInfo(
            parcName: "Parc de l'ile Saint Denis",
            championName: "HOUSSENBAY Ammar",
            creatorImage:
                "https://images.pexels.com/photos/5611966/pexels-photo-5611966.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            creatorName: "HOUSSENBAY Ammar",
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          Text(
            "Equipements disponible",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          ParcInfoEquipmentAvailableRow(),
          ParcInfoTabDisplay(),
        ],
      ),
    );
  }
}
