import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class UserPersonalInformationSettingsScreen extends StatelessWidget {
  const UserPersonalInformationSettingsScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "USER PERSONAL INFORMATION",
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: tertiaryColor.withOpacity(0.1),
          ),
          padding: EdgeInsets.all(kPaddingValue),
          child: child,
        ),
      ],
    );
  }
}
