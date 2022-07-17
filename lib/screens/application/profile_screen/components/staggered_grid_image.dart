import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

class StaggeredGridImage extends StatelessWidget {
  const StaggeredGridImage({
    Key? key,
    required this.index,
    this.height,
    this.width,
    this.onTap,
  }) : super(key: key);

  final double? height;
  final double? width;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              Faker.instance.image.image(),
            ),
          ),
        ),
        child: Text('$index'),
      ),
    );
  }
}
