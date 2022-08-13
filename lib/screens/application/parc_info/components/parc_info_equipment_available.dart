import 'package:flutter/material.dart';
import '../../../../models/material_available.dart';
import '../../../../../utils/colors.dart';

class ParcInfoEquipmentAvailableRow extends StatelessWidget {
  ParcInfoEquipmentAvailableRow({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List list;
  @override
  Widget build(BuildContext context) {
    List<MaterialAvailable> listMaterialAvailable = MaterialAvailable.buildRow(list);
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor.withOpacity(0.6),
                // image: DecorationImage(
                //   image: AssetImage(listMaterialAvailable[index].image),
                //   fit: BoxFit.contain,
                // ),
              ),
              child: Tooltip(
                message: listMaterialAvailable[index].name,
                child: Image.asset(
                  listMaterialAvailable[index].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
