import 'package:flutter/material.dart';

class RoundedCircleUserProfileWidget extends StatelessWidget {
  const RoundedCircleUserProfileWidget({
    Key? key,
    this.gradient,
    required this.radius,
    required this.imageUrl,
  }) : super(key: key);

  final Gradient? gradient;
  final double radius;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:   EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
