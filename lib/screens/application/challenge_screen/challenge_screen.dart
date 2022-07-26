import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/services/realtime_database/realtime_database_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';

import '../../../widgets/app_bar.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);
  static String name = "ChallengeScreen";

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool flag = true;
  bool isSearchingForPersonArround = false;
  late CustomUser customUser;
  void challengerFunction() {
    isSearchingForPersonArround = true;
    animationController.forward().whenComplete(
      () {
        setState(
          () {
            isSearchingForPersonArround = false;
            animationController.reset();
          },
        );
        Future.delayed(const Duration(seconds: 3)).whenComplete(() {
          setState(() {
            flag = !flag;
          });
        });
      },
    );
    setState(() {
      flag = !flag;
    });
  }

  void evaluatorFunction() async {
    await RealtimeDatabaseMethods().createParcReference(
      customUser.favoriteParc,
      customUser.uid,
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    customUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: buildAppBar(context, "Challenge"),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Lottie.network(
              "https://assets9.lottiefiles.com/packages/lf20_WVGdOg.json",
              controller: animationController,
            ),
          ),
          BottomPartChallengeScreen(
            flag: flag,
            isSearchingForPersonArround: isSearchingForPersonArround,
            onTap: challengerFunction,
          )
        ],
      ),
    );
  }
}

class BottomPartChallengeScreen extends StatelessWidget {
  const BottomPartChallengeScreen({
    Key? key,
    required this.flag,
    required this.isSearchingForPersonArround,
    required this.onTap,
  }) : super(key: key);

  final bool flag;
  final bool isSearchingForPersonArround;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: flag
            ? Container(
                key: const Key('1'),
                // color: Colors.red,
                child: Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text(
                          "Welcome to the Challenge",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          "Here you can unlock new levels, improve your score and challenge others.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: kPaddingValue * 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPaddingValue),
                          child: Column(
                            children: [
                              RoundedButton(
                                onTap: onTap,
                                text: "Get assessed",
                              ),
                              const SizedBox(
                                height: kSmallPaddingValue,
                              ),
                              RoundedButton(
                                onTap: () {
                                  debugPrint("Challenger");
                                },
                                text: "Rate someone",
                              ),
                              const SizedBox(
                                height: kSmallPaddingValue,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "What if no appraiser is available?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                margin: const EdgeInsets.all(kRadiusValue),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadiusValue),
                  color: tertiaryColor.withOpacity(0.15),
                ),
                key: const Key('2'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: kPaddingValue,
                    ),
                    const Text(
                      "Finding people arround you",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const HorizontalLine(),
                    !isSearchingForPersonArround
                        ? const Center(
                            child: Text(
                              "No person arround found please make sure someone is arround",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.all(kSmallPaddingValue),
                                  child: ListTile(
                                    // tileColor: tertiaryColor.withOpacity(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(kRadiusValue),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        Faker.instance.image.image(),
                                      ),
                                      radius: 22,
                                    ),
                                    trailing: const FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                    ),
                                    title: Text(
                                      Faker.instance.name.firstName(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      Faker.instance.datatype.string(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
