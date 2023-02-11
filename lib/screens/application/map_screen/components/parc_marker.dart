import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParcMarker with ClusterItem {
  final String name;
  final String address;
  final String id;
  final LatLng latLng;

  ParcMarker({
    required this.name,
    required this.latLng,
    required this.address,
    required this.id,
  });

  @override
  LatLng get location => latLng;
}
