import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/services/firestore_methods.dart';
import 'package:street_workout_final/services/storage/storage_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';

import 'components/profile_header_widget.dart';
import 'components/user_profile_body_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userUid}) : super(key: key);
  static String name = "ProfileScreen";
  final String userUid;

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

    user = await FirestoreMethods().findUserByUid(widget.userUid);
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
                // actions: [
                //   Center(
                //     child: Padding(
                //       padding: const EdgeInsets.only(right: 10),
                //       child: MyPopupMenu(
                //         child: FaIcon(
                //           FontAwesomeIcons.arrowUpFromBracket,
                //           size: kDefaultIconAppBar,
                //           key: GlobalKey(),
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
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
                // expandedBody: const ParcInfoExpandedBody(),
                backgroundColor: backgroundColor,
                appBarColor: primaryColor,
              ),
      ),
    );
  }
}
