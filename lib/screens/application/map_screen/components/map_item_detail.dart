import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_button.dart';
import 'map_marker.dart';

class MapItemDetails extends StatelessWidget {
  MapItemDetails({
    Key? key,
    required this.item,
  }) : super(key: key);
  final MapMarker item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPaddingValue),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadiusValue)),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(kRadiusValue), child: Image.network(item.image))),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      item.address,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingValue * 5),
              child: RoundedButton(
                onTap: () {},
                text: 'More info',
                height: 30,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
