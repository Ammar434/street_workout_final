import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/firestore_methods/parc_firestore_methods.dart';

import '../../../models/material_available.dart';
import '../../../provider/user_provider.dart';
import '../../../services/geolocalisation/geolocalisation.dart';
import '../../../services/image_picker.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/rounded_button.dart';
import 'components/add_photo.dart';
import 'components/enter_parc_detail.dart';
import 'components/parc_info_selectable_row.dart';

List userSelectedImageList = [];

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static String name = "PostScreen";
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TextEditingController textEditingControllerParcName;
  List<MaterialAvailable> selectedMaterial = [];
  bool isLoading = false;
  late final Geolocalisation _geolocalisation;
  late LatLng userCurrentPosition;

  var lat = 0.0;
  var long = 0.0;

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    _geolocalisation = Geolocalisation();

    Position p = await _geolocalisation.determinePosition();
    userCurrentPosition = LatLng(p.latitude, p.longitude);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> publishPost() async {
    String title = "";
    String content = "";
    ContentType contentType;
    setState(() {
      isLoading = true;
    });
    try {
      CustomUser currentUser = Provider.of<UserProvider>(context, listen: false).getUser!;

      String res = await ParcFirestoreMethods().uploadPost(
        listFile: userSelectedImageList,
        parcName: textEditingControllerParcName.text,
        materialAvailable: selectedMaterial,
        userId: currentUser.uid,
        latitude: lat,
        longitude: long,
      );

      debugPrint("res $res");

      if (res == "Success") {
        title = "Posted";
        content = "Thank's! Your content will be appear soon";
        contentType = ContentType.success;
      } else {
        title = "Error";
        content = res;
        contentType = ContentType.failure;
      }
    } catch (e) {
      title = "Error";
      content = e.toString();
      contentType = ContentType.failure;
    }

    setState(() {
      isLoading = false;
    });
    lat = 0.0;
    long = 0.0;
    userSelectedImageList = [];
    selectedMaterial = [];
    textEditingControllerParcName.clear();

    customShowSnackBar(
      globalKey: _scaffoldKey,
      title: title,
      content: content,
      contentType: contentType,
    );
  }

  selectImage() async {
    List<Uint8List> im = await pickMultipleImage(ImageSource.gallery);
    setState(() {
      userSelectedImageList.addAll(im);
    });
  }

  void addToSelectedIndexList(MaterialAvailable index) {
    if (selectedMaterial.contains(index)) {
      selectedMaterial.remove(index);
    } else {
      selectedMaterial.add(index);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();

    textEditingControllerParcName = TextEditingController();
  }

  @override
  void dispose() {
    userSelectedImageList = [];
    selectedMaterial = [];
    textEditingControllerParcName.clear();
    textEditingControllerParcName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Add new parc"),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
            child: Column(
              children: [
                AddPhoto(
                  function1: selectImage,
                  function2: (index) {
                    setState(
                      () {
                        userSelectedImageList.removeAt(index);
                      },
                    );
                  },
                ),
                EnterParcDetails(
                  textEditingControllerParcName: textEditingControllerParcName,
                  // functionForPrediction: functionForPrediction,
                ),
                SizedBox(
                  height: kPaddingValue * 2,
                ),
                buildMap(context),
                buildEquipmentSelect(context),
                SizedBox(
                  height: kPaddingValue * 2,
                ),
                RoundedButton(
                  onTap: () async {
                    await publishPost();
                  },
                  text: "Publish",
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildMap(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusValue),
        color: Theme.of(context).cardColor,
      ),
      child: isLoading
          ? const LoadingWidget()
          : ClipRRect(
              borderRadius: BorderRadius.circular(kRadiusValue),
              child: Stack(
                children: [
                  GoogleMap(
                    //For drag map
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    mapType: MapType.hybrid,
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    // liteModeEnabled: true,
                    // markers: markers,
                    onMapCreated: ((GoogleMapController controller) async {
                      String syle = await DefaultAssetBundle.of(context).loadString("assets/maps/map_template.json");
                      controller.setMapStyle(syle);
                      setState(() {
                        mapController = controller;
                      });
                    }),
                    initialCameraPosition: CameraPosition(
                      zoom: 16,
                      target: userCurrentPosition,
                    ),
                    onCameraMove: (CameraPosition cp) {
                      cameraPosition = cp; //when map is dragging
                    },
                    onCameraIdle: () async {
                      lat = cameraPosition!.target.latitude;
                      long = cameraPosition!.target.longitude;
                      debugPrint("lat $lat $long");
                    },
                  ),
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.locationDot,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Column buildEquipmentSelect(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Material available",
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
        ParcEquipmentSelectableRow(
          function: addToSelectedIndexList,
          selectedIndex: selectedMaterial,
        ),
      ],
    );
  }
}
