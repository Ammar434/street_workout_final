import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../models/workout.dart';
import '../../../../../services/search/search_methods.dart';
import '../../../../../utils/constants.dart';

import '../../../../../utils/colors.dart';
import '../../during_training/during_training_screen.dart';

class SearchFieldWidgetForTraining extends StatelessWidget {
  const SearchFieldWidgetForTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      getImmediateSuggestions: true,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: iconColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kRadiusValue),
          ),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
          hintText: "Search workout",
          prefixIcon: const Icon(
            Icons.search,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: tertiaryColor),
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
        ),
      ),
      suggestionsCallback: (String pattern) {
        return SearchMethods().getWorkoutSuggestion(pattern.toLowerCase());
      },
      itemBuilder: (BuildContext context, Workout suggestion) {
        return ListTile(
          tileColor: Colors.transparent,
          leading: SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.dumbbell,
                color: secondaryColor,
              ),
            ),
          ),
          title: Text(
            suggestion.name,
            style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      onSuggestionSelected: (Workout suggestion) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DuringTrainingScreen(
              workout: suggestion,
            ),
          ),
        );
      },
    );
  }
}
