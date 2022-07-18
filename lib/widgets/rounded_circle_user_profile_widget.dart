import 'package:flutter/material.dart';

class RoundedCircleUserProfileWidget extends StatelessWidget {
  const RoundedCircleUserProfileWidget({
    Key? key,
    this.gradient,
    required this.radius,
  }) : super(key: key);

  final Gradient? gradient;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: const NetworkImage(
            "https://images.pexels.com/photos/6833828/pexels-photo-6833828.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ),
        ),
      ),
    );
  }
}
