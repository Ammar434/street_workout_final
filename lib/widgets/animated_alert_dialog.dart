import 'package:flutter/material.dart';
import 'package:street_workout_final/utils/constants.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
      this.img})
      : super(key: key);
  final String title, descriptions, text;
  final Image? img;

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kPaddingValue),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: kPaddingValue,
              top: kRadiusValue + kPaddingValue,
              right: kPaddingValue,
              bottom: kPaddingValue),
          margin: const EdgeInsets.only(top: kRadiusValue),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(kPaddingValue),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: kPaddingValue,
        //   right: kPaddingValue,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: kRadiusValue,
        //     child: ClipRRect(
        //         borderRadius:
        //             const BorderRadius.all(Radius.circular(kRadiusValue)),
        //         child: Image.asset("assets/model.jpeg")),
        //   ),
        // ),
      ],
    );
  }
}
