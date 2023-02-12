import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../../../../../../common_libs.dart";
import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/user_provider.dart';
import 'firebase_animated_list_widget.dart';

class ChallengeIsStartWidget extends StatelessWidget {
  const ChallengeIsStartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    return Container(
      key: const Key("1"),
      margin: EdgeInsets.all(kRadiusValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusValue),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: kPaddingValue,
          ),
          Text(
            "Finding evaluator arround you",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const HorizontalLine(),
          FirebaseAnimatedListWidget(currentUser: currentUser),
        ],
      ),
    );
  }
}
