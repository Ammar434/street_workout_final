import 'package:flutter/material.dart';

class AuthScreenTopPart extends StatelessWidget {
  const AuthScreenTopPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Image.asset(
        "assets/images/authentication/image0_authentication.png",
      ),
    );
  }
}
