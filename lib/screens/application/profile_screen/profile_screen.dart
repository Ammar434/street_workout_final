import 'package:flutter/material.dart';

import '../../../models/custom_user.dart';
import '../../../models/rewards.dart';
import '../../../services/firebase_storage/firebase_storage_methods.dart';
import '../../../services/firestore_methods/rewards_firestore_methods.dart';
import '../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/loading_widget.dart';
import 'components/profile_screen_body_tab.dart';
import 'profile_screen_body_top.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userUid, this.userProvided}) : super(key: key);
  static String name = "ProfileScreen";
  final String userUid;
  final CustomUser? userProvided;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  final int tabCategorieLenght = 2;

  List<String> listUrlImage = [];
  List<Reward> listReward = [];
  late CustomUser user;
  void loadData() async {
    setState(() {
      isLoading = true;
    });

    if (widget.userProvided != null) {
      user = widget.userProvided!;
    } else {
      user = await UserFirestoreMethods().findUserByUid(widget.userUid);
    }
    listUrlImage = await FirebaseStorageMethods().getAllImageOfAUser(user.uid);

    listReward = await RewardsFirestoreMethods().getAllRewardsOfAUser(user);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: isLoading
          ? const LoadingWidget()
          : ProfileScreenBody(
              tabCategorieLenght: tabCategorieLenght,
              user: user,
              listUrlImage: listUrlImage,
              listReward: listReward,
            ),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    Key? key,
    required this.tabCategorieLenght,
    required this.user,
    required this.listUrlImage,
    required this.listReward,
  }) : super(key: key);

  final int tabCategorieLenght;
  final CustomUser user;
  final List<String> listUrlImage;
  final List<Reward> listReward;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabCategorieLenght,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            ProfileScreenBodyTop(user: user),
          ];
        },
        body: ProfileScreenBodyTab(
          listUrlImage: listUrlImage,
          listReward: listReward,
        ),
      ),
    );
  }
}
