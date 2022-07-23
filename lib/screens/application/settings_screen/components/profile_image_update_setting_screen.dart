import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/user_provider.dart';
import '../../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../../services/image_picker.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';

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
    // CustomUser customUser = Provider.of<UserProvider>(context).getUser;

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
                  await UserFirestoreMethods().updateUserProfileImage(file);
                  setState(() {
                    isLoading = false;
                  });
                  if (!mounted) return;
                  Provider.of<UserProvider>(context).refreshUser();
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
