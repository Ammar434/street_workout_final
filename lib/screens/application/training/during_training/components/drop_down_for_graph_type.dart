import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

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
          // style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(
          kRadiusValue,
        ),
      ),
      child: Row(
        children: [
          Text(
            "Graphique type :",
            style: Theme.of(context).textTheme.bodyLarge,
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
