import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/training/select_training/select_trainning_screen.dart';
import '../../../../../models/custom_user.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/text_style.dart';
import '../../../../../widgets/solid_circle_icon.dart';

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
          style: kTextStyleImportance4.copyWith(fontSize: 16),
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
