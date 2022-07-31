import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_end/challenge_end_screen_challenger.dart';
import 'package:street_workout_final/screens/application/challenge_screen/challenge_in_progress/components/selectable_row_emoji.dart';
import 'package:street_workout_final/screens/application/challenge_screen/components/user_detail_column_widget.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

class ChallengeInProgressScreen extends StatelessWidget {
  const ChallengeInProgressScreen({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    Challenge challenge = Provider.of<ChallengeProvider>(context).getChallenge;

    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;

    return challenge.challengerUid == currentUser.uid
        ? ChallengeInProgressChallengerScreen(
            challenge: challenge,
          )
        : const ChallengeInProgressEvaluatorScreen();
  }
}

class ChallengeInProgressEvaluatorScreen extends StatelessWidget {
  const ChallengeInProgressEvaluatorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context);
    Challenge challenge = challengeProvider.getChallenge;

    double repetionRating = 0;
    double executionRating = 0;
    if (challenge.isChallengeEnd) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeEndChallengerScreen(
            isChallengeSucceed: (challenge.executionRating + challenge.repetionRating) >= 5,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: buildAppBar(context, "Rate your experience"),
      // backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserDetailColumnItem(
            imageUrl: challenge.challengerImageUrl,
            userName: challenge.challengerName,
            imageRadius: kRadiusValueImageProfile,
            fontSize: 18,
          ),
          const SizedBox(
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
          const SizedBox(
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
          const SizedBox(
            height: kPaddingValue * 1,
          ),
          const Text(
            "In your opinion how was the global form of the mouvement",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
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
              debugPrint("dff");
              String path = "${challenge.parcId}/${challenge.evaluatorUid}";
              challengeProvider.endTheChallenge(
                path: path,
                repetionRating: repetionRating,
                executionRating: executionRating,
              );
            },
            text: 'Finish',
          ),
        ],
      ),
    );
  }
}

class ChallengeInProgressChallengerScreen extends StatelessWidget {
  const ChallengeInProgressChallengerScreen({
    Key? key,
    required this.challenge,
  }) : super(key: key);
  final Challenge challenge;
  @override
  Widget build(BuildContext context) {
    if (challenge.isChallengeEnd) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeEndChallengerScreen(
            isChallengeSucceed: (challenge.executionRating + challenge.repetionRating) >= 5,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: const Center(
        child: Text(
          'You re being evaluated now, do your best champion but always remmenber there is no honor and no progress in cheating. ',
        ),
      ),
    );
  }
}

class SelectableEmojiRow extends StatefulWidget {
  const SelectableEmojiRow({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  State<SelectableEmojiRow> createState() => _SelectableEmojiRowState();
}

class _SelectableEmojiRowState extends State<SelectableEmojiRow> {
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "Describe ${widget.challenge.challengerName} with one emoji",
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          Expanded(
            // height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mapEmoji.length,
              itemBuilder: (context, index) => Container(
                width: 100,
                margin: const EdgeInsets.all(kPaddingValue),
                padding: const EdgeInsets.all(kSmallPaddingValue),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusValue),
                  color: selectIndex == index ? iconColor.withOpacity(0.25) : null,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        mapEmoji.values.elementAt(index).imagePath,
                        width: 100,
                        height: 80,
                      ),
                      const SizedBox(
                        height: kPaddingValue,
                      ),
                      Text(
                        mapEmoji.values.elementAt(index).emojiText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // const SelectableRowEmoji(),
        ],
      ),
    );
  }
}
