import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:street_workout_final/services/authentication/authentication_method.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/text_field_input.dart';

import '../../../../utils/constants.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    Key? key,
  }) : super(key: key);
  @override
  CustomDialogBoxState createState() => CustomDialogBoxState();
}

class CustomDialogBoxState extends State<CustomDialogBox> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  void onTap() async {
    setState(() {
      isLoading = true;
    });
    String responseCode = await AuthenticationMethod().deleteUser(password: textEditingController.text);

    if (responseCode == "success") {
      if (!mounted) return;

      Navigator.pop(context);
    } else {
      setState(() {
        switchChildIndex = 3;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  int switchChildIndex = 0;

  Widget childSwitcher(int i) {
    if (i == 0) {
      return contentBox(context);
    }

    if (i == 1) {
      return contentBox2(context);
    }

    return contentBox3(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kPaddingValue),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.linearToEaseOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: childSwitcher(switchChildIndex),
      ),
    );
  }

  contentBox(context) {
    return Container(
      key: const Key('1'),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kPaddingValue),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LottieBuilder.network("https://assets9.lottiefiles.com/packages/lf20_j6fywzxe.json"),
          const Text(
            "Delete your account",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              // color: backgroundColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "This operation is irreversible",
            style: TextStyle(
              fontSize: 14,
              // color: backgroundColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    // color: backgroundColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    switchChildIndex = 1;
                  });
                  // Navigator.of(context).pop();
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  contentBox2(context) {
    return Container(
      key: const Key('2'),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kPaddingValue),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Type your password",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                // color: backgroundColor,
              ),
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            TextFieldInput(
              textEditingController: textEditingController,
              hintText: '',
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            RoundedButton(
              onTap: onTap,
              text: "Confirm deletion",
              isLoading: isLoading,
            )
          ],
        ),
      ),
    );
  }

  contentBox3(context) {
    return Container(
      key: const Key('3'),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(kPaddingValue),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(kPaddingValue),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Password is incorrect",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                // color: backgroundColor,
              ),
            ),
            SizedBox(
              height: kPaddingValue,
            ),
            RoundedButton(
              onTap: () {
                setState(() {
                  switchChildIndex = 1;
                });
              },
              text: "Retry",
            )
          ],
        ),
      ),
    );
  }
}
