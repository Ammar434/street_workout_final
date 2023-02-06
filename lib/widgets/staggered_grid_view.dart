import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../utils/constants.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({
    Key? key,
    required this.listUrlImage,
  }) : super(key: key);
  final List<String> listUrlImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPaddingValue),
      child: MasonryGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: kPaddingValue,
        crossAxisSpacing: kPaddingValue,
        itemCount: listUrlImage.length,
        itemBuilder: (context, index) {
          return Tile(
            index: index,
            extent: (index % 5 + 1) * 100,
            image: listUrlImage[index],
          );
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
    required this.image,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    final child = InstaImageViewer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kRadiusValue * 2),
        child: Image.network(
          image,
          fit: BoxFit.contain,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              ),
            );
          },
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
