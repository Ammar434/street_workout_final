import 'package:flutter/material.dart';
import "../../../../../../common_libs.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../parc_info/parc_info_screen.dart';

import '../../../../../../models/parc.dart';
import 'add_favorite_parc.dart';

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
    ImageProvider imageProvider;

    if (listeParc[index].mainPhoto.isEmpty) {
      imageProvider = const AssetImage(
        "assets/images/errors/no_picture.png",
      );
    } else {
      imageProvider = NetworkImage(listeParc[index].mainPhoto);
    }
    return Expanded(
      child: GestureDetector(
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParcInfoScreen(
                  parc: listeParc[index],
                  parcId: listeParc[index].parcId,
                ),
              ),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                height: 80.sp,
                margin: EdgeInsets.all(25.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                listeParc[index].name,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
