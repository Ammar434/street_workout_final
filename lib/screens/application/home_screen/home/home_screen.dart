import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'components/parc_display_card.dart';
import '../../../../services/search_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchBarEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          searchBarEditingController.clear();
        },
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
              const ParcDisplayCard(),
              const ParcDisplayCard(),
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
