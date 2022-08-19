import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

String paypalUrl = "https://www.paypal.com/donate/?hosted_button_id=Q5XB555WSK47W";
String koFiUrl = "https://ko-fi.com/ammarhoussenbay";

Future<void> openUrl(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri) || uri.hasEmptyPath) {
    // showSnackBar(
    //   context: context,
    //   title: "Warning",
    //   content: "This user not indicate his instagram",
    //   contentType: ContentType.warning,
    // );
  }
}

void writeEmail() {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

// ···
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'raoulammar@outlook.fr',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Bug detected',
    }),
  );

  launchUrl(emailLaunchUri);
}

Future<void> writeRewiew(BuildContext context) async {
  String url = "";
  if (Platform.isIOS) {
    url = "AppStoreUrl";
  } else {
    url = "PlayStoreUrl";
  }

  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri) || uri.hasEmptyPath) {}
}
