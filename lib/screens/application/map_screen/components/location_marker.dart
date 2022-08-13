import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class LocationMarker extends StatelessWidget {
  LocationMarker({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double size = isSelected ? markerSizeExpanded : markerSizeShrink;
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        curve: Curves.elasticOut,
        child: FaIcon(
          size: size,
          FontAwesomeIcons.locationDot,
          color: primaryColor,
        ),
      ),
    );
  }
}
