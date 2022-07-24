import 'package:flutter/material.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import '../../../../models/custom_user.dart';
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
    return Padding(
      padding: const EdgeInsets.all(kPaddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PHOTO",
            style: TextStyle(
              // color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: kPaddingValue,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRadiusValue),
              color: tertiaryColor.withOpacity(0.1),
            ),
            padding: const EdgeInsets.all(kPaddingValue),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: kRadiusValue * 5,
                  backgroundColor: secondaryColor,
                  child: isLoading ? const LoadingWidget() : null,
                ),
                const SizedBox(
                  width: kPaddingValue,
                ),
                RoundedButton(
                  onTap: () {},
                  text: "Change profile image",
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width / 2,
                  fontSize: 14,
                ),
                // GestureDetector(
                //   onTap: () async {
                //     Uint8List file = await pickImage(ImageSource.gallery);
                //     setState(() {
                //       isLoading = true;
                //     });
                //     await UserFirestoreMethods().updateUserProfileImage(file);
                //     setState(() {
                //       isLoading = false;
                //     });
                //     if (!mounted) return;
                //     Provider.of<UserProvider>(context).refreshUser();
                //   },
                //   child: const CircleAvatar(
                //     backgroundColor: primaryColor,
                //     radius: kRadiusValue * 2,
                //     child: Center(
                //       child: FaIcon(
                //         FontAwesomeIcons.pen,
                //         size: kDefaultIconAppBar,
                //         color: iconColor,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
