import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_button.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({
    Key? key,
    required this.function1,
    required this.function2,
    required this.function3,
    required this.isFavoriteParc,
    required this.isLoading,
  }) : super(key: key);

  final void Function() function1;
  final void Function() function2;
  final void Function() function3;
  final bool isFavoriteParc;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> menuList = [
      PopupMenuItem(
        child: ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.camera,
          ),
          title: Text(
            "Add photo",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: function1,
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.shareNodes,
          ),
          title: Text(
            "Share now",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: function2,
        ),
      ),
      PopupMenuItem(
        child: RoundedButton(
          height: 50,
          onTap: function3,
          text: isFavoriteParc ? "Remove from favorite" : "Add to favorite",
          color: isFavoriteParc ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).disabledColor,
          isLoading: isLoading,
        ),
      ),
    ];

    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusValue),
      ),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 1.45,
      ),
      color: Theme.of(context).cardColor,
      itemBuilder: (BuildContext context) {
        return menuList;
      },
      // icon: icon,
      child: Center(
        child: isLoading
            ? SizedBox(width: kDefaultIconAppBarSize, height: kDefaultIconAppBarSize, child: const LoadingWidget())
            : FaIcon(
                FontAwesomeIcons.barsStaggered,
                size: kDefaultIconAppBarSize,
              ),
      ),
    );
  }
}
