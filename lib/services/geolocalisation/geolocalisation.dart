import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

import '../../models/parc.dart';
import '../../utils/dev.dart';
import '../firebase_storage/firebase_storage_methods.dart';
import '../firestore_methods/parc_firestore_methods.dart';
import '../firestore_methods/user_firestore_methods.dart';

class Geolocalisation {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    //Update lastknown position
    await UserFirestoreMethods().updateLastPosition(position: position);
    return position;
  }

  Future<String> reverseGeocoding(Position position) async {
    var params = {
      'access_token': dotenv.env['mapboxAccessToken'],
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    var p = "${position.longitude},${position.latitude}";
    var url = Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$p.json?$query');
    var res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // print(res.body);
    Map<String, dynamic> responseJason = jsonDecode(res.body);

    printLongString(responseJason["features"][2]['text'].toString());
    return responseJason["features"][2]['text'].toString();
  }

  Future<List<AutocompletePrediction>> autocompletQuery(String input) async {
    List<AutocompletePrediction> list = [];
    var googlePlace = GooglePlace(dotenv.env['googleMapKey']!);
    if (input.isNotEmpty) {
      var result = await googlePlace.autocomplete.get(input);
      if (result != null && result.predictions != null) {
        debugPrint(result.predictions!.toString());

        list = result.predictions!;
      }
    }
    return list;
  }

  Future<DetailsResult?> getDetailsResultFromGooglePlaceId(String placeId) async {
    var googlePlace = GooglePlace(dotenv.env['googleMapKey']!);
    DetailsResult? detailsResult;
    var result = await googlePlace.details.get(placeId);
    if (result != null && result.result != null) {
      detailsResult = result.result;
      // debugPrint(detailsResult!.geometry!.location!.lat.toString());
      // debugPrint(detailsResult.addressComponents.toString());
      // debugPrint(detailsResult.formattedAddress.toString());
    }
    return detailsResult;
  }

  Future<Set<Marker>> getAllMarker(Function(String) onTap) async {
    Set<Marker> markers = {};
    DocumentSnapshot documentSnapshot = await firebaseFirestore.collection("datas").doc("all_parcs_references").get();
    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
    Uint8List markerIcon = await FirebaseStorageMethods().getBytesFromAsset('assets/maps/location_marker.png', 150);

    BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);
    try {
      map.forEach(
        (key, value) async {
          GeoPoint geoPoint = value['geoPoint'] as GeoPoint;

          Marker marker = Marker(
            markerId: MarkerId(value['id']),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
            icon: bitmapDescriptor,
            infoWindow: InfoWindow(
              title: value['name'],
              snippet: value['completeAddress'],
              onTap: () => onTap(value["id"]),
            ),
          );
          markers.add(marker);
        },
      );
    } catch (e) {
      // debugPrint(e.toString());
    }
    // debugPrint(markers.length.toString());
    return markers;
  }

  Future<bool> checkDistanceBetwweenUserAndPark(String parcId) async {
    double? distance;
    Parc userFavoriteParc = await ParcFirestoreMethods().findParcrById(parcId);

    Position userCurrentPosition = await determinePosition();
    GeoPoint userPark = userFavoriteParc.geoPoint!;

    distance = Geolocator.distanceBetween(
      userCurrentPosition.latitude,
      userCurrentPosition.longitude,
      userPark.latitude,
      userPark.longitude,
    );

    return (distance < 100);
  }
}
