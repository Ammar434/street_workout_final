import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/utils/constants.dart';

import '../../../../utils/colors.dart';
import 'components/parc_info_body.dart';
import 'components/parc_info_expanded_body.dart';
import 'components/parc_info_header_widget.dart';
import 'components/pop_up/my_pop_up_menu.dart';

class ParcInfoScreen extends StatelessWidget {
  const ParcInfoScreen({Key? key}) : super(key: key);
  static const String name = "ParcInfoScreen";

  @override
  Widget build(BuildContext context) {
    String parcName = "Parc de l'ile Saint Denis";
    String parcImage =
        "https://www.guichenpontrean.fr/medias/sites/7/2020/07/image-park.jpg";

    return SafeArea(
      child: DraggableHome(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: kDefaultIconAppBar,
            ),
          ),
        ),
        title: Text(parcName),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MyPopupMenu(
                child: FaIcon(
                  FontAwesomeIcons.arrowUpFromBracket,
                  size: kDefaultIconAppBar,
                  key: GlobalKey(),
                ),
              ),
            ),
          ),
        ],
        headerWidget: ParcInfoHeaderWidget(
          parcImage: parcImage,
        ),
        body: const [
          ParcInfoBodyWidget(),
        ],
        fullyStretchable: true,
        expandedBody: const ParcInfoExpandedBody(),
        backgroundColor: backgroundColor,
        appBarColor: primaryColor,
      ),
    );
  }
}
