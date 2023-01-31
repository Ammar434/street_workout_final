import 'package:flutter/material.dart';

import '../../../../../../utils/constants.dart';

class UserDetailColumnItem extends StatelessWidget {
  const UserDetailColumnItem({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.fontSize = 14,
    this.imageRadius = 32,
  }) : super(key: key);

  final String imageUrl;
  final String userName;
  final double fontSize;
  final double imageRadius;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: imageRadius),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          userName,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: fontSize,
            // color: primaryColor,
          ),
        ),
      ],
    );
  }
}
