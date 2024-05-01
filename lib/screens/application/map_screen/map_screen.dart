// import 'dart:async';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:street_workout_final/services/geolocalisation/geolocalisation.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import '../../../services/firebase_storage/firebase_storage_methods.dart';
import '../parc_info/parc_info_screen.dart';
import 'components/parc_marker.dart';

// Clustering maps

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late ClusterManager _manager;
  late List<ParcMarker> items;
  late final Geolocalisation _geolocalisation;
  late LatLng userCurrentPosition;
  Set<Marker> markers = {};
  late Uint8List markerIcon;
  final Completer<GoogleMapController> _controller = Completer();
  bool isLoading = true;

  void loadData() async {
    markerIcon = await FirebaseStorageMethods().getBytesFromAsset('assets/maps/location_marker.png', 100.sp.toInt());

    _geolocalisation = Geolocalisation();
    Position p = await _geolocalisation.determinePosition();
    userCurrentPosition = LatLng(p.latitude, p.longitude);
    items = await _geolocalisation.getAllMarker();
    _manager = _initClusterManager();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<ParcMarker>(
      items,
      _updateMarkers,
      markerBuilder: (dynamic item) => _markerBuilder(item as Cluster<ParcMarker>),
      extraPercent: 0.2,
      stopClusteringZoom: 14.0,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: isLoading
            ? const LoadingWidget()
            : GoogleMap(
                padding: EdgeInsets.only(bottom: 50.sp),
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  zoom: 14,
                  target: userCurrentPosition,
                ),
                markers: markers,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                onMapCreated: (GoogleMapController controller) async {
                  String syle = await DefaultAssetBundle.of(context).loadString(
                    "assets/maps/map_template.json",
                  );

                  controller.setMapStyle(syle);
                  _controller.complete(controller);
                  _manager.setMapId(controller.mapId);
                  setState(() {});
                },
                onCameraMove: _manager.onCameraMove,
                onCameraIdle: _manager.updateMap,
              ),
      ),
    );
  }

  void onInfoWindowTap(String s) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ParcInfoScreen(
          parcId: s,
        ),
      ),
    );
  }

  Future<Marker> Function(Cluster<ParcMarker>) get _markerBuilder => (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          infoWindow: cluster.isMultiple
              ? InfoWindow.noText
              : InfoWindow(
                  title: cluster.items.first.name,
                  snippet: cluster.items.first.address,
                  onTap: () => onInfoWindowTap(cluster.items.first.id),
                ),
          icon: await _getMarkerBitmap(
            cluster.isMultiple ? 160.sp.toInt() : 130.sp.toInt(),
            cluster.isMultiple,
            text: cluster.isMultiple ? cluster.count.toString() : null,
          ),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, bool isCluster, {String? text}) async {
    if (!isCluster) {
      BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);
      return bitmapDescriptor;
    }
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Theme.of(context).colorScheme.tertiaryContainer;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: size / 3),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
