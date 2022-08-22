import 'package:flutter/material.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class SelectableRowEmoji extends StatelessWidget {
  SelectableRowEmoji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mapEmoji.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(kRadiusValue),
            splashColor: primaryColor,
            customBorder: CircleBorder(),
            // onTap: () => function(materialAvailableList[index]),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Image.asset(
                    mapEmoji.values.elementAt(index).imagePath,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    mapEmoji.values.elementAt(index).emojiText,
                  ),
                ],
              ),
            ),
          );
        },
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
