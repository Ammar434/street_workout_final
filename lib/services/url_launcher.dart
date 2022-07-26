import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInstagramUrl(BuildContext context, String url) async {
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
