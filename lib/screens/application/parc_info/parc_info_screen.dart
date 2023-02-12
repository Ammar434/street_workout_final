import 'dart:typed_data';

import 'package:flutter/material.dart';
import "../../../common_libs.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/custom_user.dart';
import '../../../models/parc.dart';
import '../../../provider/user_provider.dart';
import '../../../services/firestore_methods/parc_firestore_methods.dart';
import '../../../services/firestore_methods/user_firestore_methods.dart';
import '../../../services/image_picker.dart';
import '../../../widgets/loading_widget.dart';
import 'components/parc_info_tab_display.dart';
import 'components/parc_info_top_part.dart';
import 'components/pop_up_menu/pop_up_menu.dart';

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
  late bool isMyFavoriteParc;

  late TabController _tabController;
  int _tabIndex = 0;
  List<String> listUrlImage = [];
  List<CustomUser> listCustomUser = [];

  late CustomUser customUser;

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

    isMyFavoriteParc = customUser.favoriteParc.contains(widget.parcId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    customUser = Provider.of<UserProvider>(context, listen: false).getUser!;

    parcFirestoreMethods = ParcFirestoreMethods();
    userFirestoreMethods = UserFirestoreMethods();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    loadData();
  }

  void addPhoto() async {
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
      isAdmin: customUser.isAdmin,
    );

    setState(() {
      isLoading2 = false;
    });

    if (res == "success") {
      // await userFirestoreMethods.incrementUserContribution(1);
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
  }

  void setAsFavorite() async {
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
      await UserProvider().refreshUser();

      setState(() {
        customUser = Provider.of<UserProvider>(context, listen: false).getUser!;
        isMyFavoriteParc = customUser.favoriteParc.contains(widget.parcId);
        debugPrint("isMyfav $isMyFavoriteParc");
        Navigator.pop(context);
      });
      listCustomUser = await parcFirestoreMethods.getAllAthleteOfParc(widget.parcId);
      // debugPrint("len ${listCustomUser.length}");
      // if (!mounted) {
      //   return;
      // }
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
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const LoadingWidget();
    } else {
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
                padding: EdgeInsets.all(kPaddingValue),
                child: PopUpMenuWidget(
                  function1: addPhoto,
                  function2: () {
                    //Share parc in social network
                  },
                  function3: setAsFavorite,

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
                  SizedBox(
                    height: kPaddingValue * 2,
                  ),
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
