import 'package:flutter/material.dart';

class FavoriteParcScreen extends StatelessWidget {
  const FavoriteParcScreen({Key? key}) : super(key: key);
  static String name = "FavoriteParcScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("We will develod this screen soon"),
          ],
        ),
      ),
    );
  }
}
