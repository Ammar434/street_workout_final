import 'package:latlong2/latlong.dart';

class MapMarker {
  MapMarker(this.image, this.title, this.address, this.location);

  final String image;
  final String title;
  final String address;
  final LatLng location;
}

final mapMarkers = [
  MapMarker(
    "https://www.guichenpontrean.fr/medias/sites/7/2020/07/image-park.jpg",
    "Park de street workout Guichen",
    "Guichen Pont-Réan",
    LatLng(48.857329, 2.335816),
  ),
  MapMarker(
    "https://www.guichenpontrean.fr/medias/sites/7/2020/07/image-park.jpg",
    "Park de street workout Guichen",
    "Guichen Pont-Réan",
    LatLng(48.859588, 2.379790),
  ),
];
