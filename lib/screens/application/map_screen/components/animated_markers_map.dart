import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'map_marker.dart';
import '../../../../utils/constants.dart';
import 'location_marker.dart';
import 'map_item_detail.dart';
import 'my_location_marker.dart';

class AnimatedMarkersMap extends StatefulWidget {
  AnimatedMarkersMap({Key? key}) : super(key: key);

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap> with SingleTickerProviderStateMixin {
  late MapController mapController;

  late AnimationController animationController;

  final PageController pageController = PageController();
  int selectedIndex = -1;

  List<Marker> _buildMarkers() {
    List<Marker> markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      MapMarker mapItem = mapMarkers[i];
      markerList.add(
        Marker(
          height: 40,
          width: 40,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = i;
                });
                pageController.animateToPage(
                  i,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.elasticOut,
                );
              },
              child: LocationMarker(
                isSelected: selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return markerList;
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markers = _buildMarkers();
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            minZoom: 5,
            maxZoom: 16,
            zoom: 12,
            center: myLocation,
          ),
          nonRotatedLayers: [
            TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/ammar434/cl5y4vc7o001s14og43x49sqg/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: {
                "id": "mapbox.country-boundaries-v1",
                "accessToken": dotenv.env['mapboxAccessToken']!,
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: myLocation,
                  height: 60,
                  width: 60,
                  builder: (_) {
                    return MyLocationMarker(animationController);
                  },
                ),
              ],
            ),
            MarkerLayerOptions(
              markers: markers,
            ),
          ],
        ),
        Visibility(
          visible: selectedIndex != -1,
          child: Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            height: 200,
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                MapMarker item = mapMarkers[index];
                return MapItemDetails(
                  item: item,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
