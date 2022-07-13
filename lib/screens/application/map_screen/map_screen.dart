import 'package:flutter/material.dart';
import 'components/animated_markers_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AnimatedMarkersMap();
  }
}
