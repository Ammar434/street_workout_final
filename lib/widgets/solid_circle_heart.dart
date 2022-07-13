import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class SolidCircleHeart extends StatelessWidget {
  const SolidCircleHeart({
    Key? key,
    this.isLike = false,
  }) : super(key: key);

  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LikeButton(),
    );
  }
}
