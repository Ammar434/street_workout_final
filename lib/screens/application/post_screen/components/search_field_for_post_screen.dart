import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:street_workout_final/services/geolocalisation/geolocalisation.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/utils/text_style.dart';

class SearchFieldForPostScreen extends StatelessWidget {
  const SearchFieldForPostScreen({
    Key? key,
    required this.textEditingControllerParcAddress,
    required this.function,
  }) : super(key: key);

  final TextEditingController textEditingControllerParcAddress;
  final Function(AutocompletePrediction) function;
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      minCharsForSuggestions: 4,
      // getImmediateSuggestions: true,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kRadiusValue),
          ),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        controller: textEditingControllerParcAddress,
        autofocus: false,
        style: kTextStyleImportance4,
        decoration: InputDecoration(
          hintText: "Enter your parc address",
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
        ),
      ),
      suggestionsCallback: (String pattern) async {
        return await Geolocalisation().autocompletQuery(pattern);
      },
      noItemsFoundBuilder: (context) {
        return ListTile(
          tileColor: Colors.transparent,
          leading: SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.locationDot,
                color: secondaryColor,
              ),
            ),
          ),
          title: const Text(
            "No place found please try with other word",
            style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      itemBuilder: (BuildContext context, AutocompletePrediction suggestion) {
        return ListTile(
          tileColor: Colors.transparent,
          leading: SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.locationDot,
                color: secondaryColor,
              ),
            ),
          ),
          title: Text(
            suggestion.description!,
            style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      onSuggestionSelected: function,
    );
  }
}
