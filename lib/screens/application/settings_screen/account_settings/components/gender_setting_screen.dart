import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

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
        Text(
          "GENDER",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Container(
          height: 50.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMale ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          kRadiusValue,
                        ),
                        bottomLeft: Radius.circular(
                          kRadiusValue,
                        ),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "Male",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isMale ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.tertiaryContainer,
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
