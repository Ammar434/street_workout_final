import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../../../utils/constants.dart';

class ParcDisplayCardImage extends StatelessWidget {
  const ParcDisplayCardImage({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    required this.onDoubleTap,
    required this.isLiked,
  }) : super(key: key);
  final String imageUrl;
  final GestureTapCallback onTap;
  final GestureDoubleTapCallback onDoubleTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kRadiusValue),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: LikeButton(
              isLiked: isLiked,
            ),
          ),
        ],
      ),
    );
  }
}
