import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

List<Color> defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.blueGrey,
];

class ColorPickerForAddWorkout extends StatelessWidget {
  const ColorPickerForAddWorkout({
    Key? key,
    required this.pickerColor,
    required this.function,
  }) : super(key: key);

  final Color pickerColor;
  final Function(Color) function;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: kPaddingValue,
          ),
          child: Text(
            "Color",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const HorizontalLine(),
        BlockPicker(
          pickerColor: pickerColor,
          onColorChanged: function,
          availableColors: defaultColors,
          useInShowDialog: false,
          layoutBuilder: (context, colors, child) => SizedBox(
            height: 80.sp,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [for (Color color in colors) child(color)],
            ),
          ),
        ),
      ],
    );
  }
}
