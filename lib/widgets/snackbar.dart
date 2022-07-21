import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String content,
  // required Color backgroundColor,
  required ContentType contentType,
}) {
  SnackBar snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 3),
    margin: EdgeInsets.zero,
    content: AwesomeSnackbarContent(
      title: title,
      message: content,
      contentType: contentType,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
