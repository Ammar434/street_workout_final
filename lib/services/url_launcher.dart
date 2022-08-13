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
