import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

class SelectableEmojiRow extends StatefulWidget {
  const SelectableEmojiRow({
    Key? key,
    required this.challengerName,
  }) : super(key: key);

  final String challengerName;

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
            "Describe ${widget.challengerName} with one picture",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            textAlign: TextAlign.center,
          ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mapEmoji.length,
              itemBuilder: (context, index) => Container(
                width: 100,
                margin: EdgeInsets.all(kPaddingValue),
                padding: EdgeInsets.all(kSmallPaddingValue),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusValue),
                  color: selectIndex == index ? Theme.of(context).hoverColor : null,
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
                      ClipOval(
                        child: Image.asset(
                          mapEmoji.values.elementAt(index).imagePath,
                          width: 100.sp,
                        ),
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
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_7.png", "Strong, but i'm better"),
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_8.png", "Sick performance"),
  UniqueKey().toString(): Emoji("assets/images/challenge/asset_9.png", "Keep working"),
};
