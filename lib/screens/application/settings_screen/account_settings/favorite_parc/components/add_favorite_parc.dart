import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/screens/application/home_screen/view_all_parc/view_all_parc_screen.dart';

class AddFavoriteParc extends StatelessWidget {
  const AddFavoriteParc({
    Key? key,
    required this.small,
  }) : super(key: key);
  final bool small;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewAllParcScreen()))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                height: 100,
                margin: EdgeInsets.all(25.sp),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: small ? 50.sp : 75.sp,
                  ),
                ),
              ),
            ),
            const FittedBox(
              child: Text(
                "Add parc",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
