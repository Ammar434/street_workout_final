import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";

import '../../../../../models/custom_user.dart';
import '../../../../../models/parc.dart';
import '../../../../../services/firestore_methods/parc_firestore_methods.dart';
import 'components/column_favorite_parc.dart';

class FavoriteParcChoose extends StatefulWidget {
  const FavoriteParcChoose({
    Key? key,
    required this.customUser,
  }) : super(key: key);
  final CustomUser customUser;

  @override
  State<FavoriteParcChoose> createState() => _FavoriteParcChooseState();
}

class _FavoriteParcChooseState extends State<FavoriteParcChoose> {
  final ParcFirestoreMethods parcFirestoreMethods = ParcFirestoreMethods();

  bool isLoading = false;
  List<Parc> listParc = [];

  void initData() async {
    setState(() {
      isLoading = false;
    });

    for (String e in widget.customUser.favoriteParc) {
      Parc p = await parcFirestoreMethods.findParcrById(e);

      listParc.add(p);
    }

    setState(() {
      isLoading = true;
    });
  }

  TextStyle textStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int lenListParc = widget.customUser.favoriteParc.length;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "MY FAVORITE PARC",
              style: textStyle,
            ),
            Text(
              "($lenListParc)",
              style: textStyle,
            ),
          ],
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Container(
          height: 400.sp,
          padding: EdgeInsets.all(kPaddingValue),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    ColumnFavoriteParc(
                      index: 0,
                      listeParc: listParc,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: VerticalDivider(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    ColumnFavoriteParc(
                      index: 1,
                      listeParc: listParc,
                    ),
                  ],
                ),
              ),
              const HorizontalLine(),
              Expanded(
                child: Row(
                  children: [
                    ColumnFavoriteParc(
                      index: 2,
                      listeParc: listParc,
                    ),
                    ColumnFavoriteParc(
                      index: 3,
                      listeParc: listParc,
                    ),
                    ColumnFavoriteParc(
                      index: 4,
                      listeParc: listParc,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
