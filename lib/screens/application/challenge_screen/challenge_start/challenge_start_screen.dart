import 'package:flutter/material.dart';
import "../../../../common_libs.dart";
import 'package:provider/provider.dart';

import '../../../../models/custom_user.dart';
import '../../../../provider/challenge_provider.dart';
import '../../../../provider/user_provider.dart';
import '../../../../services/challenge/challenge_services.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/loading_widget.dart';
// import '../challenger_waitting_room/challenger_waitting_room_screen.dart';
// import '../evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import '../../favorite_parc/favorite_parc_empty_screen.dart';
import '../select_challenge/select_challenge_screen.dart';
import '../waitting_room/evaluator_waitting_room/evaluator_waitting_room_screen.dart';
import 'components/challenge_is_not_start_widget.dart';

class ChallengeStartScreen extends StatefulWidget {
  const ChallengeStartScreen({Key? key}) : super(key: key);
  static String name = "ChallengeStartScreen";

  @override
  State<ChallengeStartScreen> createState() => _ChallengeStartScreenState();
}

class _ChallengeStartScreenState extends State<ChallengeStartScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late ChallengeProvider challengeProvider;
  late CustomUser currentUser;
  late ChallengeServices challengeServices;

  bool isLoading = true;
  bool isLoadingBtn1 = false;
  bool isLoadingBtn2 = false;
  String? parcId;

  void navigateToSelectChallengeScreen() {
    if (parcId == "") {
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Not near a favorite parc",
        content: "Please go to your favorite parc",
        contentType: ContentType.failure,
      );
    } else {
      challengeProvider.addChallengerValue(currentUser, parcId!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectChallengeScreen(),
        ),
      );
    }
  }

  void challengerFunction() async {
    setState(() {
      isLoadingBtn1 = true;
    });

    if (currentUser.favoriteParc.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FavoriteParcEmptyScreen(displayButton: true),
        ),
      );
    } else {
      parcId = await challengeServices.checkDistanceBetweenUserAndPark(currentUser.favoriteParc);

      navigateToSelectChallengeScreen();
    }
    setState(() {
      isLoadingBtn1 = false;
    });
  }

  void evaluatorFunction() async {
    setState(() {
      isLoadingBtn2 = true;
    });

    if (currentUser.favoriteParc.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FavoriteParcEmptyScreen(displayButton: true),
        ),
      );
    } else {
      parcId = await challengeServices.checkDistanceBetweenUserAndPark(currentUser.favoriteParc);
      if (parcId == "") {
        customShowSnackBar(
          globalKey: _scaffoldKey,
          title: "Not near a parc",
          content: "Please go near the parc",
          contentType: ContentType.failure,
        );
      } else {
        await challengeProvider.addEvaluatorValue(currentUser, parcId!);

        if (!mounted) return;
        Navigator.pushNamed(context, EvaluatorWaittingRoomScreen.name);
      }
    }
    setState(() {
      isLoadingBtn2 = false;
    });
  }

  void loadData() async {
    challengeServices = ChallengeServices();

    challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);

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
    currentUser = Provider.of<UserProvider>(context).getUser!;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Challenge"),
      body: isLoading
          ? const LoadingWidget()
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
                  isLoadingBtn1: isLoadingBtn1,
                  isLoadingBtn2: isLoadingBtn2,
                ),
              ],
            ),
    );
  }
}
