import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/user_provider.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../widgets/horizontal_line.dart';
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
        color: tertiaryColor.withOpacity(0.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: kPaddingValue,
          ),
          const Text(
            "Finding evaluator arround you",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const HorizontalLine(),
          FirebaseAnimatedListWidget(currentUser: currentUser),
        ],
      ),
    );
  }
}
