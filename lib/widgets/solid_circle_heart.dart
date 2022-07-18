import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class SolidCircleHeart extends StatelessWidget {
  const SolidCircleHeart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LikeButton(),
    );
  }
}
