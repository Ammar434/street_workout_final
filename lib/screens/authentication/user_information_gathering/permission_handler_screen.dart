import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../authentication_handler.dart';
import '../../../services/authentication/authentication_method.dart';
import '../../../services/geolocalisation/geolocalisation.dart';
import '../../../utils/constants.dart';
import '../../../widgets/rounded_button.dart';

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({Key? key}) : super(key: key);
  static const String name = "PermissionHandlerScreen";

  @override
  State<PermissionHandlerScreen> createState() => _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
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

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthenticationHandler(),
        ),
      );
    } else {
      // showSnackBar(
      //   context: context,
      //   title: "Warning",
      //   content: responseCode,
      //   contentType: ContentType.failure,
      // );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3 / 2.5,
                child: Image.asset(
                  "assets/images/authentication/image1_authentication.png",
                ),
              ),
              buildMiddle(context),
              RoundedButton(
                onTap: onTap,
                // onTap: () async {
                //   // await Permission.location.shouldShowRequestRationale;
                //   onTap();
                // },
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
        const Text(
          "Location",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Allow access to your location so we can accurately track your trainings via GPS signal",
          style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
