import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoImageSelectedWidget extends StatelessWidget {
  NoImageSelectedWidget({
    Key? key,
    required this.function1,
  }) : super(key: key);
  final VoidCallback function1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            FontAwesomeIcons.circlePlus,
            // size: SizeConfig.heightMultiplier * 5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Ajouter vos photos",
            style: TextStyle(
              // fontSize: SizeConfig.heightMultiplier * 2,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
