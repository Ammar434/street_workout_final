import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/parc_info/parc_info_screen.dart';
import 'package:street_workout_final/services/search/search_methods.dart';
import 'package:street_workout_final/utils/constants.dart';

import '../utils/colors.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        color: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kRadiusValue),
          ),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: const InputDecoration(
          hintText: "Find your parc by typing name or address",
          suffixIcon: Icon(
            Icons.search,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
        ),
      ),
      suggestionsCallback: (String pattern) async {
        return await SearchMethods().getParcSuggestion(pattern);
      },
      itemBuilder: (BuildContext context, Map<String, dynamic> suggestion) {
        return ListTile(
          tileColor: Colors.transparent,
          leading: const SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.dumbbell,
                color: secondaryColor,
              ),
            ),
          ),
          title: Text(
            suggestion['name'],
            style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            suggestion['completeAddress'],
            style: const TextStyle(
              color: backgroundColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      },
      onSuggestionSelected: (Map<String, dynamic> suggestion) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ParcInfoScreen(
              parcId: suggestion['id'],
            ),
          ),
        );
      },
    );
  }
}
