import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    Key? key,
    required this.textSettingGroup,
    // required this.isArrow,
    // required this.icon,
    // required this.iconBackgroundColor,
    // required this.text1,
    // required this.text2,
    // required this.press,
    required this.widgetList,
  }) : super(key: key);
  final String textSettingGroup;
  // final IconData icon;
  // final Color iconBackgroundColor;
  // final String text1;
  // final String text2;
  // final bool isArrow;
  // final GestureTapCallback press;
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
            style: const TextStyle(
              // color: primaryColor,
              // fontSize: SizeConfig.textMultiplier * 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
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
