import 'package:flutter/material.dart';

class SelectableImage extends StatelessWidget {
  const SelectableImage({
    Key? key,
    required this.isSelected,
    required this.imageAsset,
    required this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String imageAsset;
  final void Function(String imageAsset) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(imageAsset),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(border: Border.all(width: 3, color: isSelected ? Colors.green : Colors.transparent)),
        child: Image.asset(imageAsset),
      ),
    );
  }
}
