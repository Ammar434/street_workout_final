import 'dart:typed_data';

import 'package:flutter/material.dart';

import "../../../../common_libs.dart";

class RegisterScreenBodyTop extends StatelessWidget {
  const RegisterScreenBodyTop({
    Key? key,
    required this.image,
    required this.selectImage,
  }) : super(key: key);

  final Uint8List image;
  final GestureTapCallback selectImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hey Welcome",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Let's create your account!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: kPaddingValue * 5,
        ),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: kRadiusValueImageProfile,
                backgroundImage: MemoryImage(image),
              ),
              Positioned(
                bottom: -10.sp,
                right: -10.sp,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: selectImage,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
