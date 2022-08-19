import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class GenderSettingsScreen extends StatelessWidget {
  const GenderSettingsScreen({
    Key? key,
    required this.onTap,
    required this.isMale,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final bool isMale;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "GENDER",
          style: TextStyle(
            // color: primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: tertiaryColor.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMale ? tertiaryColor : primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          kRadiusValue,
                        ),
                        bottomLeft: Radius.circular(
                          kRadiusValue,
                        ),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Male",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isMale ? tertiaryColor : primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          kRadiusValue,
                        ),
                        bottomRight: Radius.circular(
                          kRadiusValue,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Female",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
