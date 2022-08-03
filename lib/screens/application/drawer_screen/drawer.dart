import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../models/custom_user.dart';
import '../../../provider/user_provider.dart';
import '../../../services/geolocalisation/geolocalisation.dart';
import '../../../utils/colors.dart';
import '../../../widgets/horizontal_line.dart';

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
  late String? currentUserCity;
  bool isLoading = true;

  Future<void> loadData() async {
    currentPosition = await geolocalisation.determinePosition();
    currentUserCity = await geolocalisation.reverseGeocoding(currentPosition);
    if (currentUserCity == null || currentUserCity == "") {
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

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerTopWidget(
            profileImage: customUser.profileImage,
            userName: customUser.userName,
            userUid: customUser.uid,
            userCity: currentUserCity!,
            isLoading: isLoading,
          ),
          const HorizontalLine(),
          const DrawerCategorieWidget(),
          const HorizontalLine(),
          const DrawerBottomWidget(),
        ],
      ),
    );
  }
}