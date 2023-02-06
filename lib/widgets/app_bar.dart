import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title, {List<Widget>? trailling}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: Center(
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.chevron_left,
        ),
      ),
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    actions: trailling ?? [],
  );
}
