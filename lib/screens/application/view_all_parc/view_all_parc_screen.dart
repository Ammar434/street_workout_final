import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/screens/application/home_screen/components/parc_display_card.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

class ViewAllParcScreen extends StatefulWidget {
  ViewAllParcScreen({Key? key}) : super(key: key);
  static String name = "ViewAllParcScreen";
  @override
  State<ViewAllParcScreen> createState() => _ViewAllParcScreenState();
}

class _ViewAllParcScreenState extends State<ViewAllParcScreen> {
  late ScrollController scrollController;

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
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
            future: FirebaseFirestore.instance.collection("parcs").where("isPublished", isEqualTo: true).get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
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
                      if (scale > 1) scale = 1;
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
              return SizedBox(
                height: 400,
                width: double.infinity,
                child: LoadingWidget(),
              );
            }),
      ),
    );
  }
}
