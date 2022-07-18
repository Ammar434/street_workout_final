import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/post_screen/components/no_image_selected.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';

import 'image_selected_widget.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({
    Key? key,
    required this.function1,
    required this.function2,
  }) : super(key: key);
  final VoidCallback function1;
  final Function(int) function2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: userSelectedImageList.isEmpty
          ? NoImageSelectedWidget(
              function1: function1,
            )
          : ImageSelectedWidget(
              function1: function1,
              function2: function2,
            ),
    );
  }
}
