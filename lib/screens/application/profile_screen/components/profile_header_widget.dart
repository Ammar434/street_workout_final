import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../services/url_launcher.dart';
import '../../../../utils/constants.dart';

import '../../../../../widgets/solid_circle_chevron_left.dart';

class ProfileHeaderWidget extends StatelessWidget {
  ProfileHeaderWidget({
    Key? key,
    required this.profileImage,
    required this.instagramLink,
  }) : super(key: key);

  final String profileImage;
  final String instagramLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        gradient: LinearGradient(colors: [
          Color(0xff232526),
          Color(0xff414345),
        ]),
        image: DecorationImage(image: NetworkImage(profileImage), fit: BoxFit.fitWidth),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: kPaddingValue),
        child: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SolidCircleChevronLeft(),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => openUrl(context, instagramLink),
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xffE1306C),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
