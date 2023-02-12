import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import "../../../../common_libs.dart";
import 'custom_dialog_body_widget.dart';

class AchievementLogoWidget extends StatelessWidget {
  const AchievementLogoWidget({
    Key? key,
    required this.isAchieve,
    required this.image,
  }) : super(key: key);
  final bool isAchieve;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        displayCustomDialog(context);
      },
      child: Container(
        // height: 100,
        width: 125,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
          ),
        ),
        child: Center(
          child: Stack(
            // fit: StackFit.expand,
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: Image.asset(
                  image,
                ),
              ),
              Visibility(
                visible: isAchieve,
                child: Positioned(
                  bottom: 0,
                  right: kPaddingValue,
                  child: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> displayCustomDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialogBodyWidget();
      },
    );
  }
}
