import 'package:flutter/material.dart';

class FavoriteParcScreen extends StatelessWidget {
  FavoriteParcScreen({Key? key}) : super(key: key);
  static String name = "FavoriteParcScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Favorite PArc Select"),
            Text("We will develod this screen soon"),
          ],
        ),
      ),
    );
  }
}
