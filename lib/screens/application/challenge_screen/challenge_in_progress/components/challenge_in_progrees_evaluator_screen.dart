import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_in_progress/components/selectable_row_emoji.dart';

import '../../../../../models/challenge.dart';
import '../../../../../models/custom_user.dart';
import '../../../../../provider/challenge_provider.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/app_bar.dart';
import '../../../../../widgets/horizontal_line.dart';
import '../../../../../widgets/rounded_button.dart';
import '../../challenge_end/challenge_end_screen_challenger/challenge_end_screen_challenger.dart';
import '../../challenge_end/challenge_end_screen_evaluator/challenge_end_screen_evaluator.dart';
import '../../waitting_room/global_waitting_room/components/user_detail_column_widget.dart';

class ChallengeInProgressEvaluatorScreen extends StatelessWidget {
  const ChallengeInProgressEvaluatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    Challenge challenge = challengeProvider.getChallenge;
    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    double repetionRating = 0;
    double executionRating = 0;

    if (challenge.isChallengeEnd) {
      if (currentUser.uid == challenge.challengerUid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeEndChallengerScreen(
              isChallengeSucceed: (challenge.executionRating + challenge.repetitionRating) >= 5,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChallengeEndScreenEvaluator(),
          ),
        );
      }
    }
    return Scaffold(
      appBar: buildAppBar(context, "Rate your experience"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserDetailColumnItem(
            imageUrl: challenge.challengerImageUrl,
            userName: challenge.challengerName,
            imageRadius: kRadiusValueImageProfile,
            fontSize: 18,
            shouldAnimate: false,
          ),
          SizedBox(
            height: kPaddingValue * 2,
          ),
          Text(
            "Tell us how ${challenge.evaluatorName} perform remmenber you have to evaluate if ${challenge.evaluatorName} can do 10 pull ups",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const HorizontalLine(),
          Text(
            "${challenge.evaluatorName} managed to do the number of repetitions indicated?",
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const FaIcon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                repetionRating = rating;
                // print(rating);
              },
            ),
          ),
          SizedBox(
            height: kPaddingValue * 1,
          ),
          const Text(
            "In your opinion how was the global form of the mouvement",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const FaIcon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                executionRating = rating;
              },
            ),
          ),
          const HorizontalLine(),
          SelectableEmojiRow(challenge: challenge),
          RoundedButton(
            onTap: () {
              // challengeProvider.endTheChallenge(
              //   path: path,
              //   repetionRating: repetionRating,
              //   executionRating: executionRating,
              // );
            },
            text: 'Finish',
          ),
        ],
      ),
    );
  }
}
