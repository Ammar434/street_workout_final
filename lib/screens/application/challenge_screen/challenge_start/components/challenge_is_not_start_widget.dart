import 'package:flutter/material.dart';
import "../../../../../common_libs.dart";

import '../../../../../widgets/rounded_button.dart';
import '../../send_video/send_video_screen.dart';

class ChallengeIsNotStartWidget extends StatelessWidget {
  const ChallengeIsNotStartWidget({
    Key? key,
    required this.challengerOnTap,
    required this.evaluatorOnTap,
    required this.isLoadingBtn1,
    required this.isLoadingBtn2,
  }) : super(key: key);

  final GestureTapCallback challengerOnTap;
  final GestureTapCallback evaluatorOnTap;
  final bool isLoadingBtn1;
  final bool isLoadingBtn2;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('1'),
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "Welcome to the Challenge",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Here you can unlock new levels, improve your score and challenge others.",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kPaddingValue * 3,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
            child: Column(
              children: [
                RoundedButton(
                  onTap: challengerOnTap,
                  text: "Get assessed",
                  isLoading: isLoadingBtn1,
                ),
                SizedBox(
                  height: kSmallPaddingValue,
                ),
                RoundedButton(
                  onTap: evaluatorOnTap,
                  text: "Rate someone",
                  isLoading: isLoadingBtn2,
                ),
                SizedBox(
                  height: kSmallPaddingValue,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SendVideoScreen(),
                ),
              );
            },
            child: Text(
              "What if no appraiser is available?",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ],
      ),
    );
  }
}
