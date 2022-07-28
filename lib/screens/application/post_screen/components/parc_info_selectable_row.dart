import 'package:flutter/material.dart';

import '../../../../models/material_available.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class ParcEquipmentSelectableRow extends StatelessWidget {
  const ParcEquipmentSelectableRow(
      {Key? key, required this.function, required this.selectedIndex})
      : super(key: key);

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
              splashColor: primaryColor,
              customBorder: const CircleBorder(),
              onTap: () => function(materialAvailableList[index]),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex.contains(materialAvailableList[index])
                      ? primaryColor
                      : secondaryColor,
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
