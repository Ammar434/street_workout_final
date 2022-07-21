import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class ParcDisplayCardInfo extends StatelessWidget {
  const ParcDisplayCardInfo({
    Key? key,
    required this.creatorImage,
    required this.parcName,
    required this.creatorName,
    required this.championName,
  }) : super(key: key);
  final String creatorImage;
  final String parcName;
  final String creatorName;
  final String championName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            parcName,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("By"),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: kRadiusValue,
              backgroundImage: NetworkImage(creatorImage),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              creatorName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: primaryColor,
                child: FaIcon(
                  FontAwesomeIcons.trophy,
                  size: 25,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                width: kPaddingValue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Champion",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0.01,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    championName == "unknown"
                        ? "No champion yet"
                        : championName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.only(left: kPaddingValue),
        //   child: Text(
        //     "Equipements disponible",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //     // textAlign: TextAlign.left,
        //   ),
        // ),
      ],
    );
  }
}
