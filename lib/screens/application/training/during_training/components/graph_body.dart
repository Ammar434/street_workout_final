import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';

class GraphBody extends StatefulWidget {
  const GraphBody({
    Key? key,
  }) : super(key: key);

  @override
  State<GraphBody> createState() => _GraphBodyState();
}

final List<String> items = ["Estimated 1RM", "Max weight", "Max reps"];

class _GraphBodyState extends State<GraphBody> {
  String? val = items[0];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          DropDownForGraphType(
            val: val,
            list: items,
            onChanged: (String? v) => setState(
              () {
                val = v;
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
