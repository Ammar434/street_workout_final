import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';
import '../../../../models/custom_user.dart';
import '../../../../models/parc.dart';
import '../../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_button.dart';
import '../../parc_info/parc_info_screen.dart';
import 'parc_display_card_info.dart';
import 'parc_display_card_mage.dart';

double pacrDisplayCardHeight = 400;

class ParcDisplayCard extends StatefulWidget {
  const ParcDisplayCard({
    Key? key,
    required this.parc,
    // required this.userWhoPublished,
  }) : super(key: key);
  final Parc parc;
  // final CustomUser userWhoPublished;
  @override
  State<ParcDisplayCard> createState() => _ParcDisplayCardState();
}

class _ParcDisplayCardState extends State<ParcDisplayCard> {
  bool isLiked = false;
  bool isLoading = false;
  late CustomUser userWhoPublished;
  late CustomUser userChampion;
  late UserFirestoreMethods userFirestoreMethods;
  void loadData() async {
    setState(() {
      isLoading = true;
    });
    userWhoPublished = await userFirestoreMethods.findUserByUid(widget.parc.userUidWhoPublish);

    userChampion = await userFirestoreMethods.findUserByUid(widget.parc.userUidChampion);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    userFirestoreMethods = UserFirestoreMethods();
    loadData();
    super.initState();
  }

  void onParcTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParcInfoScreen(
          parcId: widget.parc.parcId,
          parc: widget.parc,

          // champion: userChampion,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kPaddingValue),
      width: double.infinity,
      height: pacrDisplayCardHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: isLoading
          ? const LoadingWidget()
          : PhysicalModel(
              color: Theme.of(context).shadowColor,
              elevation: kDefaultElevation,
              child: Column(
                children: [
                  ParcDisplayCardImage(
                    imageUrl: widget.parc.mainPhoto,
                    onTap: onParcTap,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: tertiaryColor.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: kPaddingValue,
                        ),
                        ParcDisplayCardInfo(
                          parcName: widget.parc.name,
                          champion: userChampion,
                          creator: userWhoPublished,
                        ),
                        RoundedButton(
                          text: 'More information',
                          onTap: onParcTap,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
