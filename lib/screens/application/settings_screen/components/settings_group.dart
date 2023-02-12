import 'package:flutter/material.dart';

import "../../../../common_libs.dart";

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    Key? key,
    required this.textSettingGroup,
    required this.widgetList,
  }) : super(key: key);
  final String textSettingGroup;

  final List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textSettingGroup,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          ...List.generate(
            widgetList.length,
            (index) => widgetList[index],
          ),
        ],
      ),
    );
  }
}
