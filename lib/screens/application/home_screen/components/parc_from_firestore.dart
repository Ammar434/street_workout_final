import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import 'parc_display_card.dart';

class ParcFromFirestore extends StatelessWidget {
  const ParcFromFirestore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("parcs").snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400,
            width: double.infinity,
            child: LoadingWidget(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No parcs for the moments"),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Parc parc = Parc.postFromSnapshot(
              snapshot.data!.docs[index],
            );

            return ParcDisplayCard(
              parc: parc,
            );
          },
        );
      },
    );
  }
}
