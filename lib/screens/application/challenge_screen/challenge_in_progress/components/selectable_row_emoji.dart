import 'package:flutter/material.dart';

import '../../../../../models/challenge.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

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
                margin: EdgeInsets.all(kPaddingValue),
                padding: EdgeInsets.all(kSmallPaddingValue),
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
                      SizedBox(
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

          //   SelectableRowEmoji(),
        ],
      ),
    );
  }
}

class Emoji {
  Emoji(this.imagePath, this.emojiText);
  String imagePath;
  String emojiText;
}

Map<String, Emoji> mapEmoji = {
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_2.png", "Strong, but i'm better"),
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_3.png", "Sick performance"),
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_4.png", "Keep going"),
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_5.png", "Awesome"),
};
