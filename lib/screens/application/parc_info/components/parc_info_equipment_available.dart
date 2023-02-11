import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../models/material_available.dart';

class ParcInfoEquipmentAvailableRow extends StatelessWidget {
  const ParcInfoEquipmentAvailableRow({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List list;
  @override
  Widget build(BuildContext context) {
    List<MaterialAvailable> listMaterialAvailable = MaterialAvailable.buildRow(list);
    return SizedBox(
      height: kRadiusValueImageProfile,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              width: kRadiusValueImageProfile * 1,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColorLight,
                image: DecorationImage(
                    image: AssetImage(
                      listMaterialAvailable[index].image,
                    ),
                    fit: BoxFit.scaleDown),
              ),
              child: Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: listMaterialAvailable[index].name,
              ),
            );
          },
        ),
      ),
    );
  }
}
