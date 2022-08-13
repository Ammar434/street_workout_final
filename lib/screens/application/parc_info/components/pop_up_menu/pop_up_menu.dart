import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/rounded_button.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget({
    Key? key,
    required this.function1,
    required this.function2,
    required this.function3,
    required this.favorite,
    required this.isLoading,
  }) : super(key: key);

  final void Function() function1;
  final void Function() function2;
  final void Function() function3;
  final bool favorite;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> menuList = [
      PopupMenuItem(
        child: ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.camera,
            color: primaryColor,
          ),
          title: const Text(
            "Add photo",
            style: TextStyle(color: backgroundColor),
          ),
          onTap: function1,
        ),
      ),
      PopupMenuItem(
        child: ListTile(
          leading: const FaIcon(
            FontAwesomeIcons.shareNodes,
            color: primaryColor,
          ),
          title: const Text(
            "Share now",
            style: TextStyle(color: backgroundColor),
          ),
          onTap: function2,
        ),
      ),
      PopupMenuItem(
        child: RoundedButton(
          height: 100,
          onTap: function3,
          text: favorite ? "Remove as main parc" : "Set as main parc",
          color: favorite ? primaryColor : tertiaryColor,
        ),
      ),
    ];

    List<PopupMenuEntry> loadingList = [
      PopupMenuItem(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: LoadingWidget()),
              const Text(
                "Upload in progress",
                style: TextStyle(color: backgroundColor),
              )
            ],
          ),
        ),
      ),
    ];

    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusValue),
      ),
      constraints: BoxConstraints(
        // maxWidth: MediaQuery.of(context).size.width / 1.25,
        // maxHeight: MediaQuery.of(context).size.height / 3,
        // minHeight: MediaQuery.of(context).size.height / 3,
        minWidth: MediaQuery.of(context).size.width / 1.45,
      ),
      color: iconColor,
      itemBuilder: (BuildContext context) {
        if (isLoading) {
          return loadingList;
        }
        return menuList;
      },
      // icon: icon,
      child: Center(
        child: isLoading
            ? LoadingWidget()
            : FaIcon(
                FontAwesomeIcons.arrowUpFromBracket,
                size: kDefaultIconAppBar,
              ),
      ),
    );
  }
}
