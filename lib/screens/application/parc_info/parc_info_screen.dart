import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'components/parc_info_top_part.dart';
import '../../../services/image_picker.dart';
import '../../../widgets/snackbar.dart';
import '../../../models/custom_user.dart';
import '../../../models/parc.dart';
import '../../../provider/user_provider.dart';
import '../../../services/firestore_methods/parc_firestore_methods.dart';
import '../../../services/firestore_methods/user_firestore_methods.dart';
import 'components/parc_info_tab_display.dart';
import 'components/pop_up_menu/pop_up_menu.dart';
import '../../../utils/constants.dart';
import '../../../widgets/loading_widget.dart';

class ParcInfoScreen extends StatefulWidget {
  const ParcInfoScreen({
    Key? key,
    required this.parcId,
    this.parc,
  }) : super(key: key);
  static String name = "ParcInfoScreen";
  final String parcId;
  final Parc? parc;

  @override
  State<ParcInfoScreen> createState() => _ParcInfoScreenState();
}

class _ParcInfoScreenState extends State<ParcInfoScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late ParcFirestoreMethods parcFirestoreMethods;
  late UserFirestoreMethods userFirestoreMethods;

  late CustomUser champion;
  late Parc parc;
  bool isLoading = true;
  bool isLoading2 = false;
  bool isMyFavoriteParc = false;

  late TabController _tabController;
  int _tabIndex = 0;
  List<String> listUrlImage = [];
  List<CustomUser> listCustomUser = [];

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    if (widget.parc != null) {
      parc = widget.parc!;
    } else {
      parc = await parcFirestoreMethods.findParcrById(widget.parcId);
    }
    champion = await userFirestoreMethods.findUserByUid(parc.userUidChampion);
    listUrlImage = await parcFirestoreMethods.getAllImageOfParc(widget.parcId);
    listCustomUser = await parcFirestoreMethods.getAllAthleteOfParc(widget.parcId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    parcFirestoreMethods = ParcFirestoreMethods();
    userFirestoreMethods = UserFirestoreMethods();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    CustomUser customUser = Provider.of<UserProvider>(context).getUser;

    if (isLoading) {
      return const LoadingWidget();
    } else {
      isMyFavoriteParc = parc.athletesWhoTrainInThisParc.contains(customUser.uid);

      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: kDefaultIconAppBarSize,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PopUpMenuWidget(
                  function1: () async {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context);

                    setState(() {
                      isLoading2 = true;
                    });
                    String res = await parcFirestoreMethods.uploadImageToAExistingParc(
                      file: file,
                      parcId: widget.parcId,
                      userUidWhoPublish: customUser.uid,
                    );

                    setState(() {
                      isLoading2 = false;
                    });

                    if (res == "success") {
                      await userFirestoreMethods.incrementUserContribution(1);
                      customShowSnackBar(
                        title: "Thank's",
                        content: "Your content will appear soon",
                        contentType: ContentType.success,
                        globalKey: _scaffoldKey,
                      );
                    } else {
                      customShowSnackBar(
                        title: "Error",
                        content: "Some error happened please retry",
                        contentType: ContentType.failure,
                        globalKey: _scaffoldKey,
                      );
                    }
                  },
                  function2: () {
                    //Share parc in social network
                  },
                  function3: () async {
                    setState(() {
                      isLoading2 = true;
                    });
                    String res = await parcFirestoreMethods.addOrRemoveAthleteToAParc(
                      parcUid: widget.parcId,
                      parcName: parc.name,
                      athleteUid: customUser.uid,
                    );
                    if (res == "success") {
                      customShowSnackBar(
                        title: "Update",
                        content: "Your update has been take",
                        contentType: ContentType.success,
                        globalKey: _scaffoldKey,
                      );
                      parc = await parcFirestoreMethods.findParcrById(widget.parcId);
                      isMyFavoriteParc = parc.athletesWhoTrainInThisParc.contains(customUser.uid);
                      if (!mounted) {
                        return;
                      }
                      Navigator.pop(context);
                      listCustomUser = await parcFirestoreMethods.getAllAthleteOfParc(widget.parcId);
                    } else {
                      customShowSnackBar(
                        title: "Error",
                        content: "Some error happened please retry",
                        contentType: ContentType.failure,
                        globalKey: _scaffoldKey,
                      );
                    }

                    setState(() {
                      isLoading2 = false;
                    });
                  },
                  isFavoriteParc: isMyFavoriteParc,
                  isLoading: isLoading2,
                  // isLoading: isLoading2,
                ),
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(kRadiusValue),
              child: ListView(
                // shrinkWrap: true,
                children: [
                  ParcInfoTopPart(parc: parc, champion: champion),
                  ParcInfoTabDisplay(
                    parc: parc,
                    tabController: _tabController,
                    index: _tabIndex,
                    listCustomUser: listCustomUser,
                    listUrlImage: listUrlImage,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
