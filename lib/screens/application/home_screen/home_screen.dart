import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import '../../../../services/search_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

import 'components/parc_display_card.dart';
import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchBarEditingController;

  @override
  void initState() {
    super.initState();
    searchBarEditingController = TextEditingController();
  }

  @override
  void dispose() {
    searchBarEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        searchBarEditingController.clear();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            children: [
              const HomeHeader(),
              buildTypeAheadField(context),
              const SizedBox(height: kPaddingValue),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nearby park",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kPaddingValue),
              const ParcFromFirestore(),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TypeAheadField<String> buildTypeAheadField(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: searchBarEditingController,
        autofocus: false,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        cursorColor: secondaryColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
          hintText: "Find your parc",
          suffixIcon: Icon(
            Icons.search,
            color: secondaryColor,
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return CitiesService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: Text(suggestion.toString()),
          tileColor: backgroundColor.withOpacity(0.6),
          selectedTileColor: tertiaryColor,
          // subtitle: Text('\$${suggestion['price']}'),
        );
      },
      onSuggestionSelected: (suggestion) {
        debugPrint("Item tap");
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(product: suggestion)));
      },
      noItemsFoundBuilder: (context) {
        return const ListTile(
          // leading: const Icon(Icons.find_in_page),
          title: Text("The parc you search is not found"),
          // subtitle: Text('\$${suggestion['price']}'),
        );
      },
    );
  }
}

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
            debugPrint(parc.mainPhoto);

            return ParcDisplayCard(
              parc: parc,
            );
          },
        );
      },
    );
  }
}
