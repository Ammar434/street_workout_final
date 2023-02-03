import 'package:flutter/material.dart';

import '../../../../../../utils/constants.dart';

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'What you have to do:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: kSmallPaddingValue,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
