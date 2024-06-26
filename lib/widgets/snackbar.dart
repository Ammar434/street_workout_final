import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import "../common_libs.dart";

void customShowSnackBar({
  required GlobalKey<ScaffoldState> globalKey,
  required String title,
  required String content,
  // required Color backgroundColor,
  required ContentType contentType,
}) {
  SnackBar snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
    margin: EdgeInsets.zero,
    content: AwesomeSnackbarContent(
      inMaterialBanner: true,
      title: title,
      message: content,
      contentType: contentType,
    ),
  );
  ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(snackBar);
}

void showSnackbarBuildLater({
  required GlobalKey<ScaffoldState> globalKey,
}) {
  SnackBar snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
    margin: EdgeInsets.zero,
    content: AwesomeSnackbarContent(
      inMaterialBanner: true,
      title: "Not develop yet",
      message: "We will add this functionality on the next release",
      contentType: ContentType.help,
    ),
  );
  ScaffoldMessenger.of(globalKey.currentContext!).showSnackBar(snackBar);
}
