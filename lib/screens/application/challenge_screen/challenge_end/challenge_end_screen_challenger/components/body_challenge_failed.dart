import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/custom_user.dart';
import '../../../../../../provider/user_provider.dart';
import '../../../../../../utils/constants.dart';

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
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Always remmenber",
          style: TextStyle(
            fontSize: kDefaultTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Text(
          "In life, there is no such thing as impossible; it’s always possible. ~",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kDefaultTitleSize * 0.6,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
