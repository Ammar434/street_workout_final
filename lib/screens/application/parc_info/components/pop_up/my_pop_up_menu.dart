import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/screens/application/parc_info/components/pop_up/pop_up_menu_content.dart';

class MyPopupMenu extends StatefulWidget {
  final Widget child;
  MyPopupMenu({Key? key, required this.child})
      : assert(child.key != null),
        super(key: key);

  @override
  MyPopupMenuState createState() => MyPopupMenuState();
}

class MyPopupMenuState extends State<MyPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPopupMenu,
      child: widget.child,
    );
  }

  void _showPopupMenu() {
    //Find renderbox object
    RenderBox renderBox = (widget.child.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopupMenuContent(
          position: position,
          size: renderBox.size,
          onAction: (x) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text('Action => $x'),
              ),
            );
          },
        );
      },
    );
  }
}
