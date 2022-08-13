import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import '../../../../models/parc.dart';
import 'parc_display_card.dart';
import '../../../../widgets/loading_widget.dart';

class ParcFromFirestore extends StatelessWidget {
  const ParcFromFirestore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    GeoHasher geoHasher = GeoHasher();
    String geoHash = geoHasher.encode(currentUser.lastPosition.longitude, currentUser.lastPosition.latitude, precision: 5);
    print("geoHAsh$geoHash");
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
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No parcs for the moments"),
            );
          }
          List<Parc> listParc = [];

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Parc parc = Parc.postFromSnapshot(snapshot.data!.docs[index]);

              return ParcDisplayCard(parc: parc);
            },
          );
        }
        return const SizedBox(
          height: 400,
          width: double.infinity,
          child: LoadingWidget(),
        );
      },
    );
  }
}
