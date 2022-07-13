import 'package:flutter/material.dart';
import 'map_marker.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/rounded_button.dart';

class MapItemDetails extends StatelessWidget {
  const MapItemDetails({
    Key? key,
    required this.item,
  }) : super(key: key);
  final MapMarker item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingValue),
      child: Card(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Image.network(item.image)),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      item.address,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ))
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kPaddingValue * 5),
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
