import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../challenge_screen/challenge_start/challenge_start_screen.dart';
import '../../training/start_training/start_training_screen.dart';
import 'drawer_categorie_tile.dart';

class DrawerBottomWidget extends StatelessWidget {
  const DrawerBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.dumbbell,
          text: "Start a training",
          onTap: () {
            Navigator.pushNamed(context, StartTrainingScreen.name);
          },
        ),
        DrawerCategorieTile(
          iconData: FontAwesomeIcons.khanda,
          text: "Start a challenge",
          onTap: () {
            Navigator.pushNamed(context, ChallengeStartScreen.name);
          },
        ),
      ],
    );
  }
}
