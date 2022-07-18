import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';

import '../../home_screen/components/parc_display_card_info.dart';
import 'parc_info_equipment_available.dart';
import 'parc_info_tab_display.dart';

class ParcInfoBodyWidget extends StatelessWidget {
  const ParcInfoBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kPaddingValue,
        left: kSmallPaddingValue,
        right: kSmallPaddingValue,
      ),
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
          ParcInfoEquipmentAvailableRow(),
          // ParcInfoPhotosTab(),

          ParcInfoTabDisplay(),
        ],
      ),
    );
  }
}
