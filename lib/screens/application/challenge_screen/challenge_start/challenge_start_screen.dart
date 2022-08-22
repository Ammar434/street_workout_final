import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/custom_user.dart';
import '../../../../provider/challenge_provider.dart';
import '../../../../provider/user_provider.dart';
import '../challenger_waitting_room/challenger_waitting_room_screen.dart';
import '../evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import '../../favorite_parc/favorite_parc_screen.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/snackbar.dart';

import '../../../../widgets/app_bar.dart';
import 'components/challenge_is_not_start_widget.dart';

class ChallengeStartScreen extends StatefulWidget {
  ChallengeStartScreen({Key? key}) : super(key: key);
  static String name = "ChallengeStartScreen";

  @override
  State<ChallengeStartScreen> createState() => _ChallengeStartScreenState();
}

class _ChallengeStartScreenState extends State<ChallengeStartScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late CustomUser currentUser;

  bool isLoading = true;
  bool isNearAPark = false;

  Future<void> checkDistanceBetwweenUserAndPark() async {
    //TODO:reactivate

    // isNearAPark = await Geolocalisation().checkDistanceBetwweenUserAndPark(currentUser.favoriteParc);
    isNearAPark = true;
  }

  void challengerFunction() async {
    await checkDistanceBetwweenUserAndPark();
    if (isNearAPark == false) {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Not near a parc",
        content: "Please go near the parc",
        contentType: ContentType.failure,
      );
    } else {
      if (!mounted) return;
      if (currentUser.favoriteParc.isEmpty) {
        Navigator.pushNamed(context, FavoriteParcScreen.name);
      } else {
        // Navigator.of(context).pushNamed(SelectChallengeScreen.name);
        Navigator.of(context).pushNamed(ChallengerWaittinRoomScreen.name);
      }
    }
  }

  void evaluatorFunction() async {
    await checkDistanceBetwweenUserAndPark();
    if (isNearAPark == false) {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Not near a parc",
        content: "Please go near the parc",
        contentType: ContentType.failure,
      );
    } else {
      if (!mounted) return;
      if (currentUser.favoriteParc.isEmpty) {
        Navigator.pushNamed(context, FavoriteParcScreen.name);
      } else {
        Navigator.of(context).pushNamed(EvaluatorWaittingRoomScreen.name);
      }
    }
  }

  void loadData() async {
    ChallengeProvider challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
    await challengeProvider.listenToRoomComplete();
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
    currentUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Challenge"),
      body: isLoading
          ? LoadingWidget()
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(kPaddingValue * 2),
                    child: Image.asset(
                      "assets/images/challenge/asset_0.png",
                    ),
                  ),
                ),
                ChallengeIsNotStartWidget(
                  challengerOnTap: challengerFunction,
                  evaluatorOnTap: evaluatorFunction,
                ),
              ],
            ),
    );
  }
}
