import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../authentication_handler.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../services/geolocalisation/geolocalisation.dart';
import '../../../utils/constants.dart';
import '../../../utils/text_style.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/snackbar.dart';

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({Key? key}) : super(key: key);
  static String name = "PermissionHandlerScreen";

  @override
  State<PermissionHandlerScreen> createState() => _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  void onTap() async {
    setState(() {
      isLoading = true;
    });
    Position position = await Geolocalisation().determinePosition();
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
    String responseCode = await AuthenticationMethod().registerUser(geoPoint);

    if (responseCode == "success") {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthenticationHandler(),
        ),
      );
    } else {
      customShowSnackBar(
        title: "Warning",
        content: responseCode,
        contentType: ContentType.failure,
        globalKey: _scaffoldkey,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(child: SizedBox()),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  "assets/images/authentication/image1_authentication.png",
                ),
              ),
              buildMiddle(context),
              RoundedButton(
                onTap: onTap,
                text: "Complete",
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildMiddle(BuildContext context) {
    return Column(
      children: [
        Text(
          "Location",
          style: kTextStyleImportance3,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: kSmallPaddingValue,
        ),
        Text(
          "Allow access to your location so we can accurately track your trainings via GPS signal",
          style: kTextStyleHintTextImportance3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
