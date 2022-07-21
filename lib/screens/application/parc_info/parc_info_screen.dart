import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/screens/application/parc_info/components/parc_info_equipment_available.dart';
import 'package:street_workout_final/screens/application/parc_info/components/parc_info_tab_display.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class ParcInfoScreen extends StatelessWidget {
  const ParcInfoScreen({
    Key? key,
    required this.parc,
    required this.champion,
  }) : super(key: key);
  static const String name = "ParcInfoScreen";
  final CustomUser champion;
  final Parc parc;

  @override
  Widget build(BuildContext context) {
    debugPrint(parc.materialAvailable.toString());

    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: kDefaultIconAppBar,
              ),
            ),
          ),
          actions: const [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: FaIcon(
                  FontAwesomeIcons.arrowUpFromBracket,
                  size: kDefaultIconAppBar,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(kRadiusValue),
          child: ListView(
            shrinkWrap: true,
            children: [
              AspectRatio(
                aspectRatio: 3 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadiusValue),
                    image: DecorationImage(
                        image: NetworkImage(parc.mainPhoto), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: kPaddingValue,
              ),
              Text(
                parc.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(
                height: kSmallPaddingValue,
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: primaryColor,
                    size: kDefaultIconsSize / 1.5,
                  ),
                  const SizedBox(
                    width: kSmallPaddingValue,
                  ),
                  Text(
                    parc.completeAddress,
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kPaddingValue,
              ),
              const Text(
                "About this parc",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: kSmallPaddingValue,
              ),
              ParcInfoEquipmentAvailableRow(
                list: parc.materialAvailable,
              ),
              const HorizontalLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        champion.userName == "unknown"
                            ? "No champion yet"
                            : champion.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const HorizontalLine(),
              const ParcInfoTabDisplay()
            ],
          ),
        ),
      ),
    );
  }
}
