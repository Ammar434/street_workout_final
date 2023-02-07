import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/user_provider.dart';

class BodyChallengeFailed extends StatelessWidget {
  const BodyChallengeFailed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.network(
          "https://assets2.lottiefiles.com/packages/lf20_ed9D2z.json",
          repeat: false,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "Ahh so close ${currentUser.userName}!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "Always remmenber",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "In life, there is no such thing as impossible; it’s always possible. ~",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
