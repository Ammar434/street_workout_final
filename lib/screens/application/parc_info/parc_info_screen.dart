import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/custom_user.dart';
import 'package:street_workout_final/models/parc.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/screens/application/parc_info/components/parc_info_equipment_available.dart';
import 'package:street_workout_final/screens/application/parc_info/components/parc_info_tab_display.dart';
import 'package:street_workout_final/screens/application/parc_info/components/pop_up_menu/pop_up_menu.dart';
import 'package:street_workout_final/services/firestore_methods.dart';
import 'package:street_workout_final/utils/colors.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/horizontal_line.dart';
import 'package:street_workout_final/widgets/loading_widget.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/snackbar.dart';

class ParcInfoScreen extends StatefulWidget {
  const ParcInfoScreen({
    Key? key,
    required this.parcId,
    // required this.champion,
  }) : super(key: key);
  static const String name = "ParcInfoScreen";
  // final CustomUser champion;
  final String parcId;

  @override
  State<ParcInfoScreen> createState() => _ParcInfoScreenState();
}

class _ParcInfoScreenState extends State<ParcInfoScreen> {
  late CustomUser champion;
  late Parc parc;
  bool isLoading = true;
  bool isLoading2 = false;
  Future<void> loadData() async {
    parc = await FirestoreMethods().findParcrById(widget.parcId);
    champion = await FirestoreMethods().findUserByUid(parc.userUidChampion);
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
    debugPrint(parc.materialAvailable.toString());
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;
    bool isMyFavoriteParc =
        parc.athletesWhoTrainInThisParc.contains(customUser.uid);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: kDefaultIconAppBar,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PopUpMenuWidget(
                menuList: [
                  const PopupMenuItem(
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.camera,
                        color: primaryColor,
                      ),
                      title: Text(
                        "Add photo",
                        style: TextStyle(color: backgroundColor),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.shareNodes,
                        color: primaryColor,
                      ),
                      title: Text(
                        "Share now",
                        style: TextStyle(color: backgroundColor),
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    child: RoundedButton(
                      height: 100,
                      color: isMyFavoriteParc ? tertiaryColor : primaryColor,
                      text: isMyFavoriteParc
                          ? "Remove from my favorite"
                          : "Set as my favorite",
                      isLoading: isLoading2,
                      onTap: () async {
                        setState(() {
                          isLoading2 = true;
                        });
                        String res =
                            await FirestoreMethods().addOrRemoveAthleteToAParc(
                          parc.parcId,
                          customUser.uid,
                        );

                        if (res == "success") {
                          showSnackBar(
                            context: context,
                            title: "Good job",
                            content:
                                "You select your favorite parc, you can start to compete againts other now",
                            contentType: ContentType.success,
                          );
                        } else {
                          showSnackBar(
                            context: context,
                            title: "Error",
                            content: "Some error happened please retry",
                            contentType: ContentType.warning,
                          );
                        }
                        Navigator.pop(context, false);
                        setState(() {
                          isLoading2 = false;
                        });
                      },
                    ),
                  ),
                ],
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.arrowUpFromBracket,
                    size: kDefaultIconAppBar,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(kRadiusValue),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kRadiusValue),
                          image: DecorationImage(
                              image: NetworkImage(parc.mainPhoto),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: kPaddingValue,
                    ),
                    Text(
                      parc.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: kSmallPaddingValue,
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: primaryColor,
                          size: kDefaultIconsSize / 1.5,
                        ),
                        const SizedBox(
                          width: kSmallPaddingValue,
                        ),
                        Text(
                          parc.completeAddress,
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kPaddingValue,
                    ),
                    const Text(
                      "About this parc",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: kSmallPaddingValue,
                    ),
                    ParcInfoEquipmentAvailableRow(
                      list: parc.materialAvailable,
                    ),
                    const HorizontalLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: primaryColor,
                          child: FaIcon(
                            FontAwesomeIcons.trophy,
                            size: 25,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(
                          width: kPaddingValue,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Current Champion",
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.01,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              champion.userName == "unknown"
                                  ? "No champion yet"
                                  : champion.userName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const HorizontalLine(),
                    ParcInfoTabDisplay(
                      parcId: parc,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
