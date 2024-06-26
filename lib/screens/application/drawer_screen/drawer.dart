import 'package:flutter/material.dart';
import "../../../common_libs.dart";
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/geolocalisation/geolocalisation.dart';

import 'components/drawer_adding_part.dart';
import 'components/drawer_bottom_widget.dart';
import 'components/drawer_categorie_widget.dart';
import 'components/drawer_top_widget.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  late Geolocalisation geolocalisation;
  late Position currentPosition;
  String currentUserCity = "unknown";
  bool isLoading = false;

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    currentPosition = await geolocalisation.determinePosition();
    currentUserCity = await geolocalisation.reverseGeocoding(currentPosition);
    if (currentUserCity == "") {
      currentUserCity = "unknown";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    geolocalisation = Geolocalisation();
    loadData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser!;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerTopWidget(
            profileImage: customUser.profileImage,
            userName: customUser.userName,
            userUid: customUser.uid,
            userCity: currentUserCity,
            isLoading: isLoading,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          const HorizontalLine(),
          DrawerCategorieWidget(
            scaffoldKey: _scaffoldKey,
          ),
          const HorizontalLine(),
          const DrawerBottomWidget(),
          const HorizontalLine(),
          const DrawerAddingPart(),
        ],
      ),
    );
  }
}
