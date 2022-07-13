import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/rounded_button.dart';
import '../../../../../widgets/solid_circle_heart.dart';
import '../../parc_info/parc_info_screen.dart';

class ParcDisplayCard extends StatelessWidget {
  const ParcDisplayCard({
    Key? key,
  }) : super(key: key);

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingValue, vertical: kPaddingValue),
        child: Column(
          children: [
            const ParcDisplayCardImage(
              imageUrl:
                  "https://images.pexels.com/photos/10159989/pexels-photo-10159989.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              isLike: false,
            ),
            const SizedBox(
              height: kPaddingValue,
            ),
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
    );
  }
}

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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            parcName,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              // letterSpacing: 1.05,
            ),
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          Row(
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
          const SizedBox(
            height: 10,
          ),
          Row(
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
                    championName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ParcDisplayCardImage extends StatelessWidget {
  const ParcDisplayCardImage({
    Key? key,
    required this.isLike,
    required this.imageUrl,
  }) : super(key: key);
  final bool isLike;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kRadiusValue),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: SolidCircleHeart(isLike: isLike),
          ),
        ],
      ),
    );
  }
}
