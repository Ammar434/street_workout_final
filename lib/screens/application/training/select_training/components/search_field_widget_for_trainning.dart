import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../models/workout.dart';
import '../../../../../provider/workout_provider.dart';
import '../../../../../services/search/search_methods.dart';
import '../../during_training/during_training_screen.dart';

class SearchFieldWidgetForTraining extends StatelessWidget {
  const SearchFieldWidgetForTraining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    return TypeAheadField(
      getImmediateSuggestions: true,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: Theme.of(context).iconTheme.color,
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
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.secondary,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
          ),
        ),
      ),
      suggestionsCallback: (String pattern) {
        return SearchMethods().getWorkoutSuggestion(pattern.toLowerCase(), workoutProvider.listWorkoutFromProvider);
      },
      itemBuilder: (BuildContext context, Workout suggestion) {
        return ListTile(
          tileColor: Colors.transparent,
          leading: SizedBox(
            height: double.maxFinite,
            width: kPaddingValue,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.dumbbell,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          title: Text(
            suggestion.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
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
