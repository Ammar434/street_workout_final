import 'dart:typed_data';

import 'package:flutter/material.dart';

class RegisterTopPartColumn extends StatelessWidget {
  const RegisterTopPartColumn({
    Key? key,
    this.image,
    required this.function,
  }) : super(key: key);
  final Uint8List? image;
  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hey Welcome",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Let's create your account!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        Center(
          child: Stack(
            children: [
              image != null
                  ? CircleAvatar(
                      radius: 56,
                      backgroundImage: MemoryImage(image!),
                    )
                  : const CircleAvatar(
                      radius: 56,
                      backgroundImage: AssetImage(
                        "assets/images/authentication/default_profile.png",
                      ),
                    ),
              Positioned(
                bottom: -10,
                right: -10,
                child: IconButton(
                    icon: const Icon(Icons.add_a_photo), onPressed: function),
              )
            ],
          ),
        ),
      ],
    );
  }
}
