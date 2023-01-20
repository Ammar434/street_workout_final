import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/screens/application/settings_screen/account_settings/favorite_parc/components/add_favorite_parc.dart';

class ColumnFavoriteParc extends StatelessWidget {
  const ColumnFavoriteParc({
    Key? key,
    required this.index,
    required this.listeParc,
  }) : super(key: key);

  final int index;
  final List<Parc> listeParc;
  @override
  Widget build(BuildContext context) {
    if (index > listeParc.length - 1) {
      return AddFavoriteParc(
        small: (index > 1),
      );
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 100,
              margin: EdgeInsets.all(25.sp),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(listeParc[index].mainPhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              listeParc[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
