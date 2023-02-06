import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../widgets/search_field_widget_for_parc.dart';
import 'components/parc_from_firestore.dart';
import 'home_header.dart';
import 'view_all_parc/view_all_parc_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kPaddingValue),
          child: Column(
            children: [
              const HomeHeader(),
              const SearchFieldWidgetForParc(),
              SizedBox(height: kPaddingValue),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby park",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ViewAllParcScreen.name);
                    },
                    child: Text(
                      "See all",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kPaddingValue),
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
}
