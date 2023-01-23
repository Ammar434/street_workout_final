import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
import '../../../../provider/user_provider.dart';
import '../../../../widgets/loading_widget.dart';
import 'parc_display_card.dart';

class ParcFromFirestore extends StatefulWidget {
  const ParcFromFirestore({
    Key? key,
  }) : super(key: key);

  @override
  State<ParcFromFirestore> createState() => _ParcFromFirestoreState();
}

class _ParcFromFirestoreState extends State<ParcFromFirestore> {
  late CustomUser currentUser;
  late GeoHasher geoHasher;
  String geoHash = "";
  loadData() async {
    currentUser = Provider.of<UserProvider>(context, listen: false).getUser;
    geoHasher = GeoHasher();
    geoHash = geoHasher.encode(currentUser.lastPosition.longitude, currentUser.lastPosition.latitude, precision: 5);
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("parcs")
          .where("isPublished", isEqualTo: true)
          .where(
            "geoHash",
            isEqualTo: geoHash,
          )
          .limit(10)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
          return const SizedBox(
            height: 200,
            width: double.infinity,
            child: LoadingWidget(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                "No parcs arround you for the moments, please check the See all section",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Parc parc = Parc.postFromSnapshot(snapshot.data!.docs[index]);

            return ParcDisplayCard(parc: parc);
          },
        );
      },
    );
  }
}
