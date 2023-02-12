import 'package:flutter/material.dart';
import "../common_libs.dart";
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/application/parc_info/parc_info_screen.dart';
import '../services/search/search_methods.dart';

class SearchFieldWidgetForParc extends StatelessWidget {
  const SearchFieldWidgetForParc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        // color: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kRadiusValue),
          ),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: "Type parc name or address",
          suffixIcon: const Icon(
            Icons.search,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
        ),
      ),
      suggestionsCallback: (String pattern) async {
        return await SearchMethods().getParcSuggestion(pattern);
      },
      itemBuilder: (BuildContext context, Map<String, dynamic> suggestion) {
        return ListTile(
          tileColor: Theme.of(context).cardColor,
          leading: SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.dumbbell,
                // color: secondaryColor,
              ),
            ),
          ),
          title: Text(
            suggestion['name'],
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            suggestion['completeAddress'],
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        );
      },
      onSuggestionSelected: (Map<String, dynamic> suggestion) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParcInfoScreen(
              parcId: suggestion['id'],
              parc: null,
              // champion: userChampion,
            ),
          ),
        );
      },
    );
  }
}
