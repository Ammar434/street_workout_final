import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:street_workout_final/services/geolocalisation/geolocalisation.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import '../parc_info/parc_info_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final Geolocalisation _geolocalisation;
  late LatLng userCurrentPosition;
  late Set<Marker> markers;
  bool isLoading = true;

  void onInfoWindowTap(String s) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ParcInfoScreen(
          parcId: s,
        ),
      ),
    );
  }

  void loadData() async {
    Position p = await _geolocalisation.determinePosition();
    userCurrentPosition = LatLng(p.latitude, p.longitude);
    markers = await _geolocalisation.getAllMarker(onInfoWindowTap);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _geolocalisation = Geolocalisation();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingWidget()
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              //For drag map
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              onMapCreated: ((GoogleMapController controller) async {
                String syle = await DefaultAssetBundle.of(context).loadString("assets/maps/map_template.json");
                controller.setMapStyle(syle);
              }),
              initialCameraPosition: CameraPosition(
                zoom: 14,
                target: userCurrentPosition,
              ),
            ),
          );
  }
}
