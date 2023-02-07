import 'dart:typed_data';

import 'package:flutter/material.dart';
import "package:street_workout_final/common_libs.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../models/custom_user.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../../../services/image_picker.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_button.dart';

class ProfileImageUpdateSettingScreen extends StatefulWidget {
  const ProfileImageUpdateSettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileImageUpdateSettingScreen> createState() => _ProfileImageUpdateSettingScreenState();
}

class _ProfileImageUpdateSettingScreenState extends State<ProfileImageUpdateSettingScreen> {
  bool isLoading = false;

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    CustomUser? customUser = Provider.of<UserProvider>(context, listen: true).getUser;
    imageUrl = customUser!.profileImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PHOTO",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadiusValue),
            color: Theme.of(context).cardColor,
          ),
          padding: EdgeInsets.all(kPaddingValue),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: kRadiusValue * 5,
                child: isLoading ? const LoadingWidget() : null,
              ),
              SizedBox(
                width: kPaddingValue,
              ),
              Expanded(
                child: RoundedButton(
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
