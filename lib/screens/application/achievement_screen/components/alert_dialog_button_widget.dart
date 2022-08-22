import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class AlertDialogButtonWidget extends StatelessWidget {
  AlertDialogButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              kRadiusValue,
            ),
            bottomRight: Radius.circular(
              kRadiusValue,
            ),
          ),
        ),
        child: Center(
          child: Text(
            "Claim",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
