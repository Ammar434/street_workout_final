import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/image_picker.dart';
import 'package:street_workout_final/services/storage/storage_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

class ProfileImageUpdateSettingScreen extends StatefulWidget {
  const ProfileImageUpdateSettingScreen({
    Key? key,
    required this.customUser,
  }) : super(key: key);

  final CustomUser customUser;

  @override
  State<ProfileImageUpdateSettingScreen> createState() =>
      _ProfileImageUpdateSettingScreenState();
}

class _ProfileImageUpdateSettingScreenState
    extends State<ProfileImageUpdateSettingScreen> {
  bool isLoading = false;

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    imageUrl = widget.customUser.profileImage;
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: kRadiusValue * 5,
              backgroundColor: secondaryColor,
              child: isLoading ? const LoadingWidget() : null,
            ),
            Positioned(
              right: -5,
              top: 0,
              child: GestureDetector(
                onTap: () async {
                  debugPrint("Change image");
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    isLoading = true;
                  });
                  await StorageMethods().uploadImageToStorage(
                    "profilePics",
                    file,
                    false,
                  );

                  setState(() {
                    isLoading = false;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: kRadiusValue * 2,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.pen,
                      size: kDefaultIconAppBar,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 3,
          child: Text(
            widget.customUser.userName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
