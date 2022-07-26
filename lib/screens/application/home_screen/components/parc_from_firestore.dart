import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../models/parc.dart';
import 'parc_display_card.dart';
import '../../../../widgets/loading_widget.dart';

class ParcFromFirestore extends StatelessWidget {
  const ParcFromFirestore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("parcs")
          .where("isPublished", isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
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
              Parc parc = Parc.postFromSnapshot(snapshot.data!.docs[index]);
              debugPrint("-----------------------------------------");
              debugPrint(parc.name);
              debugPrint("-----------------------------------------");

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
