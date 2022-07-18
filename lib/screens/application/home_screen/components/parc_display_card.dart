import 'package:flutter/material.dart';

import 'package:street_workout_final/widgets/rounded_button.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../parc_info/parc_info_screen.dart';
import 'parc_display_card_info.dart';
import 'parc_display_card_mage.dart';

class ParcDisplayCard extends StatefulWidget {
  const ParcDisplayCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ParcDisplayCard> createState() => _ParcDisplayCardState();
}

class _ParcDisplayCardState extends State<ParcDisplayCard> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kPaddingValue),
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kRadiusValue),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        children: [
          ParcDisplayCardImage(
            imageUrl:
                "https://images.pexels.com/photos/10159989/pexels-photo-10159989.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            isLiked: isLiked,
            onTap: () {
              Navigator.pushNamed(context, ParcInfoScreen.name);
            },
            onDoubleTap: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: tertiaryColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  const ParcDisplayCardInfo(
                    parcName: "Parc de l'ile Saint Denis",
                    championName: "HOUSSENBAY Ammar",
                    creatorImage:
                        "https://images.pexels.com/photos/5611966/pexels-photo-5611966.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    creatorName: "HOUSSENBAY Ammar",
                  ),
                  RoundedButton(
                    text: 'More information',
                    onTap: () {
                      Navigator.pushNamed(context, ParcInfoScreen.name);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
