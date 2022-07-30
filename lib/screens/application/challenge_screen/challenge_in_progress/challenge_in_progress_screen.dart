import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/challenge.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/challenge_provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/challenge_screen/components/user_detail_column_widget.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';

class ChallengeInProgressScreen extends StatelessWidget {
  const ChallengeInProgressScreen({Key? key, required this.challenge}) : super(key: key);
  final Challenge challenge;
  @override
  Widget build(BuildContext context) {
    Challenge challenge = Provider.of<ChallengeProvider>(context).getChallenge;

    CustomUser currentUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: buildAppBar(context, ""),
      // backgroundColor: primaryColor,
      body: challenge.challengerUid == currentUser.uid
          ? const Center(
              child: Text(
                'You re being evaluated, do your best champion',
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Rate your experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: kDefaultTitleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: kPaddingValue * 4,
                ),
                UserDetailColumnItem(
                  imageUrl: challenge.challengerImageUrl,
                  userName: challenge.challengerName,
                  imageRadius: kRadiusValueImageProfile,
                  fontSize: 18,
                ),
                const SizedBox(
                  height: kPaddingValue * 2,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                const SizedBox(
                  height: kPaddingValue * 1,
                ),
                Text(
                  "Tell us how ${challenge.evaluatorName} perform remmenber you have to evaluate if ${challenge.evaluatorName} can do 10 pull ups",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: kPaddingValue * 1,
                ),
                const HorizontalLine(),
                Center(
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                const Text(
                  "In your opinion how was the global form of the mouvement",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const HorizontalLine(),
                RatingBar.builder(
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                    }
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
    );
  }
}
