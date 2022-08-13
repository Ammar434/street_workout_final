import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/services/firestore_methods/user_firestore_methods.dart';
import 'package:street_workout_final/services/image_picker.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import '../../../../models/custom_user.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';

class ProfileImageUpdateSettingScreen extends StatefulWidget {
  ProfileImageUpdateSettingScreen({
    Key? key,
    required this.customUser,
  }) : super(key: key);

  final CustomUser customUser;

  @override
  State<ProfileImageUpdateSettingScreen> createState() => _ProfileImageUpdateSettingScreenState();
}

class _ProfileImageUpdateSettingScreenState extends State<ProfileImageUpdateSettingScreen> {
  bool isLoading = false;

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    // CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    imageUrl = widget.customUser.profileImage;
    return Padding(
      padding: EdgeInsets.all(kPaddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PHOTO",
            style: TextStyle(
              // color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: kPaddingValue,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRadiusValue),
              color: tertiaryColor.withOpacity(0.1),
            ),
            padding: EdgeInsets.all(kPaddingValue),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: kRadiusValue * 5,
                  backgroundColor: secondaryColor,
                  child: isLoading ? LoadingWidget() : null,
                ),
                SizedBox(
                  width: kPaddingValue,
                ),
                RoundedButton(
                  onTap: () async {
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
                  text: "Change profile image",
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width / 2,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
