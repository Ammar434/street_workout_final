import 'package:flutter/material.dart';
import 'items_for_row_profile_screen.dart';
import '../../../../utils/constants.dart';

class UserInformationDisplay extends StatelessWidget {
  const UserInformationDisplay({
    Key? key,
    required this.name,
    required this.favoriteParc,
    required this.userContribution,
    required this.userTrainingPoint,
    required this.userEvaluation,
  }) : super(key: key);

  final String name;
  final String favoriteParc;
  final int userContribution;
  final int userTrainingPoint;
  final int userEvaluation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Text(
            favoriteParc,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: kPaddingValue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemForRowProfileScreen(
                value: userContribution,
                categorieName: "CONTRIBUTIONS",
              ),
              ItemForRowProfileScreen(
                value: userTrainingPoint,
                categorieName: "Points",
              ),
              ItemForRowProfileScreen(
                value: userEvaluation,
                categorieName: "Evaluation",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
