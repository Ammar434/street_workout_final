import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class ItemForRowProfileScreen extends StatelessWidget {
  const ItemForRowProfileScreen({
    Key? key,
    required this.value,
    required this.categorieName,
  }) : super(key: key);

  final int value;
  final String categorieName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: kSmallPaddingValue,
          ),
          Text(
            categorieName,
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 12,
              // fontStyle: FontStyle.italic,
              color: hintTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
