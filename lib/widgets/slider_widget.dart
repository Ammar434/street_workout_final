import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    Key? key,
    required this.sliderDefaultValue,
    required this.min,
    required this.max,
    required this.onDrag,
    required this.sliderName,
    required this.sliderUnits,
  }) : super(key: key);
  final String sliderName;
  final String sliderUnits;
  final double sliderDefaultValue;
  final double min;
  final double max;
  final void Function(double) onDrag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            '$sliderName : ${sliderDefaultValue.round()} $sliderUnits',
            style: kTextStyleImportance4,
          ),
          Expanded(
            child: Slider(
              value: sliderDefaultValue,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              inactiveColor: Theme.of(context).disabledColor,
              activeColor: Theme.of(context).primaryColor,
              label: '${sliderDefaultValue.round()}',
              onChanged: onDrag,
            ),
          ),
        ],
      ),
    );
  }
}
