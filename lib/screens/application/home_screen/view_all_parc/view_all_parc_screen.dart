import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:street_workout_final/models/custom_user.dart';

import '../../../../models/parc.dart';
import '../../../../provider/user_provider.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/loading_widget.dart';
import '../components/parc_display_card.dart';

class ViewAllParcScreen extends StatefulWidget {
  const ViewAllParcScreen({Key? key}) : super(key: key);
  static String name = "ViewAllParcScreen";
  @override
  State<ViewAllParcScreen> createState() => _ViewAllParcScreenState();
}

class _ViewAllParcScreenState extends State<ViewAllParcScreen> {
  late ScrollController scrollController;
  late CustomUser currentUser;
  late GeoHasher geoHasher;
  String geoHash = "";

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    currentUser = Provider.of<UserProvider>(context, listen: false).getUser!;
    geoHasher = GeoHasher();
    geoHash = geoHasher.encode(currentUser.lastPosition.longitude, currentUser.lastPosition.latitude, precision: 5);
    scrollController = ScrollController();
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, 'All parc'),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("parcs")
                .where(
                  'geoHash',
                  isGreaterThanOrEqualTo: geoHash.substring(0, 4),
                )
                .where(
                  'geoHash',
                  isLessThanOrEqualTo: geoHash,
                )
                .orderBy("geoHash", descending: true)
                .limit(25)
                .get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No parcs for the moments"),
                  );
                }
                return Padding(
                  padding: EdgeInsets.all(kPaddingValue),
                  child: ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    // physics:   NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      double itemPositionOffset = pacrDisplayCardHeight * index;
                      double difference = scrollController.offset - itemPositionOffset;
                      double percent = 1 - (difference / pacrDisplayCardHeight);
                      double opacity = percent;
                      double scale = percent;

                      if (opacity > 1) opacity = 1;
                      if (opacity < 0) opacity = 0;
                      if (percent > 1) scale = 1;
                      Parc parc = Parc.postFromSnapshot(snapshot.data!.docs[index]);
                      return Opacity(
                        opacity: opacity,
                        child: Transform(
                          transform: Matrix4.identity()..scale(scale, scale),
                          alignment: Alignment.center,
                          child: ParcDisplayCard(parc: parc),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(child: LoadingWidget());
            }),
      ),
    );
  }
}
