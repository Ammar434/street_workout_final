import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

class UserDetailColumnItem extends StatelessWidget {
  const UserDetailColumnItem({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.fontSize = 14,
    this.imageRadius = 32,
    required this.shouldAnimate,
  }) : super(key: key);

  final String imageUrl;
  final String userName;
  final double fontSize;
  final double imageRadius;

  final bool shouldAnimate;
  @override
  Widget build(BuildContext context) {
    debugPrint("shouldANimate $shouldAnimate");

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: imageRadius,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: shouldAnimate
                ? TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    color: Colors.green,
                  )
                : TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    // color: primaryColor,
                  ),
            child: Text(
              userName,
            ),
          ),
        ],
      ),
    );
  }
}
