import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../models/material_available.dart';

class ParcEquipmentSelectableRow extends StatelessWidget {
  const ParcEquipmentSelectableRow({Key? key, required this.function, required this.selectedIndex}) : super(key: key);

  final void Function(MaterialAvailable) function;
  final List<MaterialAvailable> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(kRadiusValue),
              // splashColor: Theme.of(context).primaryColorLight,
              customBorder: const CircleBorder(),
              onTap: () => function(materialAvailableList[index]),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex.contains(materialAvailableList[index]) ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColorLight,
                ),
                child: Image.asset(
                  materialAvailableList[index].image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
