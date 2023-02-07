import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/post_screen/components/text_field_for_post_screen.dart';

class EnterParcDetails extends StatefulWidget {
  const EnterParcDetails({
    Key? key,
    required this.textEditingControllerParcName,
  }) : super(key: key);

  final TextEditingController textEditingControllerParcName;

  @override
  State<EnterParcDetails> createState() => _EnterParcDetailsState();
}

class _EnterParcDetailsState extends State<EnterParcDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kPaddingValue,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Enter parc informations",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidCircleQuestion,
                size: kDefaultIconsSize,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kPaddingValue),
                    ),
                    elevation: 0,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Container(
                      key: const Key('1'),
                      margin: EdgeInsets.all(kPaddingValue),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(kRadiusValue),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "If the park you add does not have a popular name, you have the honor of naming that park.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Close",
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        TextFIeldForPostScreen(
          textEditingControllerParcName: widget.textEditingControllerParcName,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
      ],
    );
  }
}

// class SelectPointOnMap extends StatefulWidget {
//   const SelectPointOnMap({
//     super.key,
//   });

//   @override
//   State<SelectPointOnMap> createState() => _SelectPointOnMapState();
// }

// class _SelectPointOnMapState extends State<SelectPointOnMap> {
//   late final Geolocalisation _geolocalisation;
//   late LatLng userCurrentPosition;

//   bool isLoading = false;
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;

//   void loadData() async {
//     setState(() {
//       isLoading = true;
//     });
//     _geolocalisation = Geolocalisation();

//     Position p = await _geolocalisation.determinePosition();
//     userCurrentPosition = LatLng(p.latitude, p.longitude);

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(kRadiusValue),
//         color: Theme.of(context).cardColor,
//       ),
//       child: isLoading
//           ? const LoadingWidget()
//           : ClipRRect(
//               borderRadius: BorderRadius.circular(kRadiusValue),
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     //For drag map
//                     gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//                       Factory<OneSequenceGestureRecognizer>(
//                         () => EagerGestureRecognizer(),
//                       ),
//                     },
//                     mapType: MapType.normal,
//                     myLocationEnabled: false,
//                     zoomControlsEnabled: false,
//                     // liteModeEnabled: true,
//                     // markers: markers,
//                     onMapCreated: ((GoogleMapController controller) async {
//                       String syle = await DefaultAssetBundle.of(context).loadString("assets/maps/map_template.json");
//                       controller.setMapStyle(syle);
//                       setState(() {
//                         mapController = controller;
//                       });
//                     }),
//                     initialCameraPosition: CameraPosition(
//                       zoom: 14,
//                       target: userCurrentPosition,
//                     ),
//                     onCameraMove: (CameraPosition cp) {
//                       cameraPosition = cp; //when map is dragging
//                     },
//                     onCameraIdle: () async {
//                       //when map drag stops
//                       // List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
//                       // setState(() {
//                       //   //get place name from lat and lang
//                       //   location = "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
//                       // });
//                     },
//                   ),
//                   Center(
//                     child: FaIcon(
//                       FontAwesomeIcons.locationDot,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
