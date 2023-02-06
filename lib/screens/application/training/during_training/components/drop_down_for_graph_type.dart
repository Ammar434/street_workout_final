import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';

class DropDownForGraphType extends StatelessWidget {
  const DropDownForGraphType({
    Key? key,
    required this.val,
    required this.list,
    required this.onChanged,
  }) : super(key: key);
  final String? val;
  final List<String> list;
  final Function(String?) onChanged;

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Center(
        child: Text(
          item,
          style: kTextStyleImportance4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(
          kRadiusValue,
        ),
      ),
      child: Row(
        children: [
          Text(
            "Graphique type :",
            style: kTextStyleImportance4,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(kSmallPaddingValue),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: val,
                  isExpanded: true,
                  alignment: Alignment.bottomRight,
                  items: list.map(buildMenuItem).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
