import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/services/search_bar.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';

class TextFieldInputWithAutoComplete extends StatelessWidget {
  const TextFieldInputWithAutoComplete(
      {Key? key,
      required this.textEditingController,
      required this.rowName,
      required this.hintText})
      : super(key: key);

  final TextEditingController textEditingController;
  final String rowName;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final inputBorder = UnderlineInputBorder(
      borderSide: Divider.createBorderSide(
        context,
        color: tertiaryColor,
        width: 2,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rowName,
              style: const TextStyle(
                // fontSize: SizeConfig.heightMultiplier * 3,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.solidCircleQuestion,
                size: kDefaultIconsSize / 1.5,
              ),
              onPressed: () {
                debugPrint("");
              },
            ),
          ],
        ),
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: textEditingController,
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.italic),
            cursorColor: secondaryColor,
            decoration: InputDecoration(
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              hintText: hintText,
            ),
          ),
          suggestionsCallback: (pattern) async {
            debugPrint("hello");
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
        )
      ],
    );
  }
}
