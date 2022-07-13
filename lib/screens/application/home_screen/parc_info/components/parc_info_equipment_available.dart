import 'package:flutter/material.dart';
import '../../../../../utils/colors.dart';

class ParcInfoEquipmentAvailableRow extends StatelessWidget {
  const ParcInfoEquipmentAvailableRow({
    Key? key,
  }) : super(key: key);

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
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor,
              ),
              child: Image.asset(
                "assets/images/exercices/image_exercice$index.png",
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
