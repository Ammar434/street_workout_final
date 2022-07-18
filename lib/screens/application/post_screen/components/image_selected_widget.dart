import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/post_screen/post_screen.dart';
import 'package:street_workout_final/utils/constants.dart';

class ImageSelectedWidget extends StatelessWidget {
  const ImageSelectedWidget({
    Key? key,
    required this.function1,
    required this.function2,
  }) : super(key: key);

  final VoidCallback function1;
  final Function(int) function2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userSelectedImageList.length + 1,
        itemBuilder: (context, index) {
          if (index == userSelectedImageList.length) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: function1,
                icon: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    // size: SizeConfig.heightMultiplier * 5,
                  ),
                ),
              ),
            );
          }
          return AspectRatio(
            aspectRatio: 1,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.all(kPaddingValue * 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      kRadiusValue,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(
                        userSelectedImageList[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => function2(index),
                    child: const FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
                      // size: SizeConfig.heightMultiplier * 4,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
