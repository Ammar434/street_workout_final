import 'package:flutter/material.dart';

import "../../../../../common_libs.dart";

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
        Text(
          "USER PERSONAL INFORMATION",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: Theme.of(context).cardColor,
          ),
          padding: EdgeInsets.all(kPaddingValue),
          child: child,
        ),
      ],
    );
  }
}
