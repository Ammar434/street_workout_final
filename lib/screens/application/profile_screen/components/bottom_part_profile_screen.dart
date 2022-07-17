import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:street_workout_final/screens/application/profile_screen/components/staggered_grid_image.dart';
import 'package:street_workout_final/utils/constants.dart';

class BottomPartProfileScreen extends StatelessWidget {
  const BottomPartProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: kPaddingValue),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return StaggeredGridImage(
          index: index,
          height: (index % 5 + 1) * 100,
        );
      },
    );
  }
}
