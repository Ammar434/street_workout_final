import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/app_bar.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'package:street_workout_final/widgets/snackbar.dart';

class EvaluatorWaittingRoomScreenBody extends StatefulWidget {
  const EvaluatorWaittingRoomScreenBody({Key? key}) : super(key: key);
  @override
  State<EvaluatorWaittingRoomScreenBody> createState() => _EvaluatorWaittingRoomScreenBodyState();
}

class _EvaluatorWaittingRoomScreenBodyState extends State<EvaluatorWaittingRoomScreenBody> {
  late final RealtimeDatabaseMethods _realtimeDatabaseMethods;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late CustomUser _customUser;
  late Timer timer;
  bool isChallengerFound = false;
  int timeDuration = 15;
  int timeDurationInitial = 15;
  bool isLoading = true;
  double opacityLevel = 0.0;
  Color timerColor = Colors.white;

  Widget buildTimer() {
    if (timeDuration > 0) {
      return Center(
        child: Text(
          timeDuration.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: kDefaultTitleSize * 3,
            // color: primaryColor,
          ),
        ),
      );
    } else {
      if (isChallengerFound) {
        return const Center(
          child: FaIcon(
            FontAwesomeIcons.check,
            color: Colors.greenAccent,
            size: kDefaultTitleSize * 3,
          ),
        );
      } else {
        return const Center(
          child: FaIcon(
            FontAwesomeIcons.xmark,
            color: Colors.redAccent,
            size: kDefaultTitleSize * 3,
          ),
        );
      }
    }
  }

  void changeOpacity() {
    setState(() => opacityLevel = 1.0);
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeDuration > 0) {
          setState(() {
            timeDuration--;
          });
        } else {
          changeOpacity();
        }
      },
    );
  }

  void loadData() async {
    String res = await _realtimeDatabaseMethods.createParcReference(_customUser);

    if (res != "success") {
      if (!mounted) return;
      Navigator.of(context).pop();
      customShowSnackBar(
        globalKey: _scaffoldKey,
        title: "Error",
        content: "Please retry",
        contentType: ContentType.failure,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _realtimeDatabaseMethods = RealtimeDatabaseMethods();
    _customUser = Provider.of<UserProvider>(context, listen: false).getUser;
    loadData();
    startTimer();

    //Etape 1 creer la room:

    //Etape 2  envoyer vers la page de waitting room

    //Etape 3 affiché le message de prevention

    //Etape 4 emmene vers la page du challenge
  }

  @override
  void dispose() {
    // _realtimeDatabaseMethods.deleteParcReference(
    //   _customUser.favoriteParc,
    //   _customUser.uid,
    // );
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, ""),
      body: isLoading
          ? const LoadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      size: kDefaultIconsSize,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: kPaddingValue,
                    ),
                    Text(
                      "Wait time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultTitleSize * 0.75,
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 10,
                              valueColor: AlwaysStoppedAnimation(timerColor),
                              backgroundColor: primaryColor,
                              value: 1 - timeDuration / timeDurationInitial,
                            ),
                            buildTimer()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: kPaddingValue,
                      ),
                      AnimatedOpacity(
                        opacity: 1 - opacityLevel,
                        duration: const Duration(seconds: 1),
                        child: const Text(
                          "Finding athletes arround you",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kDefaultTitleSize * 0.75,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: opacityLevel,
                        duration: const Duration(seconds: 5),
                        curve: Curves.linearToEaseOut,
                        child: const Text(
                          "The athlete who was to be evaluated failed to join the challenge. Please try again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kDefaultTitleSize * 0.75,
                          ),
                        ),
                        onEnd: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Stop challenge",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultTitleSize * 0.75,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}