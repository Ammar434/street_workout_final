// import 'package:flutter/material.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
// import "package:street_workout_final/common_libs.dart";
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../../../services/geolocalisation/geolocalisation.dart';

// class SearchFieldForPostScreen extends StatelessWidget {
//   const SearchFieldForPostScreen({
//     Key? key,
//     required this.textEditingControllerParcAddress,
//     required this.function,
//   }) : super(key: key);

//   final TextEditingController textEditingControllerParcAddress;
//   final Function(AutocompletePrediction) function;
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField(
//       minCharsForSuggestions: 4,
//       // getImmediateSuggestions: true,
//       suggestionsBoxDecoration: SuggestionsBoxDecoration(
//         color: Theme.of(context).iconTheme.color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(kRadiusValue),
//           ),
//         ),
//       ),
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: textEditingControllerParcAddress,
//         autofocus: false,
//         style: Theme.of(context).textTheme.bodyMedium,
//         decoration: InputDecoration(
//           hintText: "Enter your parc address",
//           border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusValue))),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
//             borderRadius: BorderRadius.all(Radius.circular(kRadiusValue)),
//           ),
//         ),
//       ),
//       suggestionsCallback: (String pattern) async {
//         return await Geolocalisation().autocompletQuery(pattern);
//       },
//       noItemsFoundBuilder: (context) {
//         return ListTile(
//           tileColor: Colors.transparent,
//           leading: SizedBox(
//             height: double.maxFinite,
//             width: kPaddingValue,
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: FaIcon(
//                 FontAwesomeIcons.locationDot,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//             ),
//           ),
//           title: Text(
//             "No place found please try with other word",
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       },
//       itemBuilder: (BuildContext context, AutocompletePrediction suggestion) {
//         return ListTile(
//           tileColor: Colors.transparent,
//           leading: SizedBox(
//             height: double.maxFinite,
//             width: kPaddingValue,
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: FaIcon(
//                 FontAwesomeIcons.locationDot,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//             ),
//           ),
//           title: Text(
//             suggestion.fullText,
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       },
//       onSuggestionSelected: function,
//     );
//   }
// }
