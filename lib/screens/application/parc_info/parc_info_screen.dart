import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/screens/application/parc_info/components/parc_info_top_part.dart';
import 'package:street_workout_final/services/image_picker.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import '../../../models/custom_user.dart';
import '../../../models/parc.dart';
import '../../../provider/user_provider.dart';
import '../../../services/firestore_methods/parc_firestore_methods.dart';
import '../../../services/firestore_methods/user_firestore_methods.dart';
import 'components/parc_info_tab_display.dart';
import 'components/pop_up_menu/pop_up_menu.dart';
import '../../../utils/constants.dart';
import '../../../widgets/horizontal_line.dart';
import '../../../widgets/loading_widget.dart';

class ParcInfoScreen extends StatefulWidget {
  const ParcInfoScreen({
    Key? key,
    required this.parcId,
    this.parc,
  }) : super(key: key);
  static const String name = "ParcInfoScreen";
  final String parcId;
  final Parc? parc;

  @override
  State<ParcInfoScreen> createState() => _ParcInfoScreenState();
}

class _ParcInfoScreenState extends State<ParcInfoScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late ParcFirestoreMethods parcFirestoreMethods;
  late UserFirestoreMethods userFirestoreMethods;

  late CustomUser champion;
  late Parc parc;
  bool isLoading = true;
  bool isLoading2 = false;
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
    listCustomUser =
        await parcFirestoreMethods.getAllAthleteOfParc(widget.parcId);
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
    bool isMyFavoriteParc = false;

    if (isLoading) {
      return const LoadingWidget();
    } else {
      isMyFavoriteParc =
          parc.athletesWhoTrainInThisParc.contains(customUser.uid);

      return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
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
                  function1: () async {
                    Navigator.pop(context);
                    Uint8List file = await pickImage(ImageSource.gallery);

                    setState(() {
                      isLoading2 = true;
                    });
                    String res =
                        await parcFirestoreMethods.uploadImageToAExistingParc(
                      file: file,
                      parcId: widget.parcId,
                      userUidWhoPublish: customUser.uid,
                    );
                    setState(() {
                      isLoading2 = false;
                    });
                    if (res == "success") {
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
                  function2: () {},
                  function3: () async {
                    Navigator.pop(context);

                    setState(() {
                      isLoading2 = true;
                    });
                    String res =
                        await parcFirestoreMethods.addOrRemoveAthleteToAParc(
                            widget.parcId, parc.name, customUser.uid);
                    setState(() {
                      isLoading2 = false;
                    });
                    if (res == "success") {
                      listCustomUser = await parcFirestoreMethods
                          .getAllAthleteOfParc(widget.parcId);
                      setState(() {});
                      customShowSnackBar(
                        title: "Good job",
                        content: "You can start compete in this parc",
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
                  favorite: isMyFavoriteParc,
                  isLoading: isLoading2,
                ),
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(kRadiusValue),
              child: ListView(
                // shrinkWrap: true,
                children: [
                  ParcInfoTopPart(parc: parc, champion: champion),
                  const HorizontalLine(),
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
