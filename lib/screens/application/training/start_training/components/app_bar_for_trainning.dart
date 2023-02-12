import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../models/custom_user.dart';
import '../../../../../widgets/solid_circle_icon.dart';
import '../../select_training/select_trainning_screen.dart';

class AppBarForTrainning extends StatelessWidget {
  String greetings() {
    String s = "";
    DateTime dateTime = DateTime.now();
    if (dateTime.hour > 6 && dateTime.hour < 15) {
      s = "Good morning 👋";
    } else {
      s = "Good evening 👋";
    }
    return s;
  }

  const AppBarForTrainning({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final CustomUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: kRadiusValueImageProfile / 3,
          backgroundImage: NetworkImage(currentUser.profileImage),
        ),
        SizedBox(
          width: kSmallPaddingValue * 2,
        ),
        Text(
          greetings(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SelectTrainningScreen.name);
          },
          child: SolidCircleIcon(
            iconData: FontAwesomeIcons.plus,
            iconSize: kDefaultIconsSize,
          ),
        )
      ],
    );
  }
}
