import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../select_training/components/workout_category_list_builder.dart';

class DropdownButtonWorkout extends StatelessWidget {
  const DropdownButtonWorkout({Key? key, required this.function, required this.dropdownValue}) : super(key: key);
  final Function(String? value) function;
  final String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.sp,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor, //background color of dropdown button
          border: Border.all(color: const Color(0xFF62656f), width: 1), //border of dropdown button
          borderRadius: BorderRadius.circular(kRadiusValue), //border raiuds of dropdown button
        ),
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: backgroundColor,
          iconSize: kDefaultIconAppBarSize,
          icon: Padding(
            padding: EdgeInsets.only(right: kPaddingValue),
            child: const FaIcon(
              FontAwesomeIcons.chevronDown,
            ),
          ),
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
          isExpanded: true,
          underline: const SizedBox(),
          onChanged: function,
          alignment: Alignment.bottomCenter,
          items: categoryNames.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.all(kPaddingValue),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
