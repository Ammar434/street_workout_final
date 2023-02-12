import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListTileForInstruction extends StatelessWidget {
  const ListTileForInstruction({
    Key? key,
    required this.item,
    required this.animation,
    this.onClicked,
  }) : super(key: key);
  final String item;
  final Animation<double> animation;
  final VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.all(kSmallPaddingValue),
        child: ListTile(
          tileColor: Theme.of(context).listTileTheme.tileColor,
          leading: const FaIcon(
            FontAwesomeIcons.solidCircle,
            size: 8,
          ),
          trailing: InkWell(
            onTap: onClicked,
            child: FaIcon(
              FontAwesomeIcons.trash,
              size: kDefaultIconsSize,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusValue),
          ),
          title: Text(
            item,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
