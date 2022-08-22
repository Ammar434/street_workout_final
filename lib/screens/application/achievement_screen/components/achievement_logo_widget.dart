import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/achievements/asset_31.png",
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
                  child: const FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: tertiaryColor,
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
        return CustomDialogBodyWidget();
      },
    );
  }
}
