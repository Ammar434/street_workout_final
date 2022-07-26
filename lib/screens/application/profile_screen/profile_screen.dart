import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/custom_user.dart';
import '../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../services/storage/storage_methods.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/loading_widget.dart';

import 'components/profile_header_widget.dart';
import 'components/user_profile_body_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userUid, this.userProvided})
      : super(key: key);
  static String name = "ProfileScreen";
  final String userUid;
  final CustomUser? userProvided;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  List<String> listUrlImage = [];
  late CustomUser user;
  void loadData() async {
    setState(() {
      isLoading = true;
    });
    listUrlImage = await StorageMethods().getAllImageOfAUser(widget.userUid);
    if (widget.userProvided != null) {
      user = widget.userProvided!;
    } else {
      user = await UserFirestoreMethods().findUserByUid(widget.userUid);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const LoadingWidget()
            : DraggableHome(
                leading: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: kDefaultIconAppBar,
                    ),
                  ),
                ),
                title: Text(user.userName),
                headerWidget: ProfileHeaderWidget(
                  profileImage: user.profileImage,
                  instagramLink: user.instagramProfile,
                ),
                body: [
                  UserProfileBodyWidget(
                    name: user.userName,
                    favoriteParc: user.favoriteParc == ""
                        ? "The user's favorite park has not been filled in"
                        : user.favoriteParc,
                    userContribution: user.numberOfContribution,
                    userTrainingPoint: user.points,
                    userEvaluation: user.numberOfEvaluation,
                    listUrlImage: listUrlImage,
                  ),
                ],
                fullyStretchable: true,
                backgroundColor: backgroundColor,
                appBarColor: primaryColor,
              ),
      ),
    );
  }
}
