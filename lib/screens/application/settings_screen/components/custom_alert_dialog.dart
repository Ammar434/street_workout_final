import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:lottie/lottie.dart';

import '../../../../services/authentication/authentication_method.dart';
import '../../../../widgets/rounded_button.dart';
import '../../../../widgets/text_field_input.dart';

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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(kPaddingValue),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LottieBuilder.network(
            "https://assets9.lottiefiles.com/packages/lf20_j6fywzxe.json",
            height: kPaddingValue * 15,
            fit: BoxFit.cover,
          ),
          Text(
            "Delete your account",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          Text(
            "This operation is irreversible",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
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
                child: Text(
                  "Confirm",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
        color: Theme.of(context).cardColor,
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
            Text(
              "Type your password",
              style: Theme.of(context).textTheme.titleMedium,
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
        color: Theme.of(context).colorScheme.secondary,
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
