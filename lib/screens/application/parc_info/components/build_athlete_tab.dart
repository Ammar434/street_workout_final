import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../models/custom_user.dart';

class BuildAthleteTab extends StatelessWidget {
  const BuildAthleteTab({
    Key? key,
    required this.listCustomUser,
  }) : super(key: key);

  final List<CustomUser> listCustomUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(listCustomUser.length + 1, (index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(top: kPaddingValue),
            child: Text(
              listCustomUser.isEmpty ? "No user train in this parc for the moment" : "Total athlete who train in this park ${listCustomUser.length}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  listCustomUser[index - 1].profileImage,
                ),
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              Text(
                listCustomUser[index - 1].userName,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
