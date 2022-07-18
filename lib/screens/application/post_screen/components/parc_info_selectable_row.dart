import 'package:flutter/material.dart';
import 'package:street_workout_final/models/material_available.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

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
// class ParcEquipmentSelectableRow extends StatefulWidget {
//   const ParcEquipmentSelectableRow({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ParcEquipmentSelectableRow> createState() =>
//       _ParcEquipmentSelectableRowState();
// }

// class _ParcEquipmentSelectableRowState
//     extends State<ParcEquipmentSelectableRow> {
//   List<int> selectedIndex = [];

//   void addToSelectedIndexList(int index) {
//     if (selectedIndex.contains(index)) {
//       selectedIndex.remove(index);
//     } else {
//       selectedIndex.add(index);
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 75,
//       // color: Colors.red,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 6,
//         itemBuilder: (context, index) {
//           return AspectRatio(
//             aspectRatio: 1,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(kRadiusValue),
//               splashColor: primaryColor,
//               customBorder: const CircleBorder(),
//               onTap: () => addToSelectedIndexList(index),
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: selectedIndex.contains(index)
//                       ? primaryColor
//                       : secondaryColor,
//                 ),
//                 child: Image.asset(
//                   "assets/images/exercices/image_exercice$index.png",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// }