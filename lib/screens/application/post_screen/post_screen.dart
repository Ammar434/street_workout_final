import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/material_available.dart';
import '../../../provider/user_provider.dart';
import '../../../services/firestore_methods/parc_firestore_methods.dart';
import '../../../services/image_picker.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/snackbar.dart';
import 'components/add_photo.dart';
import 'components/parc_info_selectable_row.dart';
import 'components/search_field_for_post_screen.dart';
import 'components/text_field_for_post_screen.dart';

List userSelectedImageList = [];

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static String name = "PostScreen";
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TextEditingController textEditingControllerParcName;
  late TextEditingController textEditingControllerParcAddress;
  List<MaterialAvailable> selectedMaterial = [];
  bool isLoading = false;
  String placeID = "";

  Future<void> publishPost({
    required String parcName,
    required String parcAddress,
    required String uid,
  }) async {
    String title = "";
    String content = "";
    ContentType contentType;
    setState(() {
      isLoading = true;
    });
    try {
      String res = await ParcFirestoreMethods().uploadPost(
        listFile: userSelectedImageList,
        parcName: parcName,
        parcAddress: parcAddress,
        materialAvailable: selectedMaterial,
        uid: uid,
        placeId: placeID,
      );

      if (res == "success") {
        title = "Posted";
        content = "Thank's! Your content will be appear soon";
        contentType = ContentType.success;
      } else {
        title = "Error";
        content = res;
        contentType = ContentType.failure;
      }
    } catch (e) {
      title = "Error";
      content = e.toString();
      contentType = ContentType.failure;
    }

    setState(() {
      isLoading = false;
    });
    userSelectedImageList = [];
    selectedMaterial = [];
    textEditingControllerParcAddress.clear();
    textEditingControllerParcName.clear();

    customShowSnackBar(
      globalKey: _scaffoldKey,
      title: title,
      content: content,
      contentType: contentType,
    );
  }

  selectImage() async {
    List<Uint8List> im = await pickMultipleImage(ImageSource.gallery);
    setState(() {
      userSelectedImageList.addAll(im);
    });
  }

  void addToSelectedIndexList(MaterialAvailable index) {
    if (selectedMaterial.contains(index)) {
      selectedMaterial.remove(index);
    } else {
      selectedMaterial.add(index);
    }
    setState(() {});
  }

  void functionForPrediction(AutocompletePrediction suggestion) {
    textEditingControllerParcAddress.text = suggestion.description!;
    placeID = suggestion.placeId!;
  }

  @override
  void initState() {
    super.initState();
    textEditingControllerParcName = TextEditingController();
    textEditingControllerParcAddress = TextEditingController();
  }

  @override
  void dispose() {
    userSelectedImageList = [];
    selectedMaterial = [];
    textEditingControllerParcAddress.clear();
    textEditingControllerParcName.clear();
    textEditingControllerParcName.dispose();
    textEditingControllerParcAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context, "Add new parc"),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
            child: Column(
              children: [
                AddPhoto(
                  function1: selectImage,
                  function2: (index) {
                    setState(
                      () {
                        userSelectedImageList.removeAt(index);
                      },
                    );
                  },
                ),
                EnterParcDetails(
                  textEditingControllerParcName: textEditingControllerParcName,
                  textEditingControllerParcAddress: textEditingControllerParcAddress,
                  functionForPrediction: functionForPrediction,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kPaddingValue),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Material available",
                            style: TextStyle(
                              // fontSize: SizeConfig.heightMultiplier * 3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidCircleQuestion,
                              size: kDefaultIconsSize / 1.5,
                            ),
                            onPressed: () {
                              debugPrint("");
                            },
                          ),
                        ],
                      ),
                      ParcEquipmentSelectableRow(
                        function: addToSelectedIndexList,
                        selectedIndex: selectedMaterial,
                      )
                    ],
                  ),
                ),
                RoundedButton(
                  onTap: () async {
                    await publishPost(
                      parcName: textEditingControllerParcName.text,
                      parcAddress: textEditingControllerParcAddress.text,
                      uid: userProvider.getUser.uid,
                    );
                  },
                  text: "Publish",
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnterParcDetails extends StatelessWidget {
  const EnterParcDetails({
    Key? key,
    required this.textEditingControllerParcName,
    required this.textEditingControllerParcAddress,
    required this.functionForPrediction,
  }) : super(key: key);

  final TextEditingController textEditingControllerParcName;
  final TextEditingController textEditingControllerParcAddress;
  final Function(AutocompletePrediction) functionForPrediction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kPaddingValue,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Enter parc informations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidCircleQuestion,
                size: kDefaultIconsSize / 1.5,
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        TextFIeldForPostScreen(
          textEditingControllerParcName: textEditingControllerParcName,
        ),
        SizedBox(
          height: kPaddingValue,
        ),
        SearchFieldForPostScreen(
          textEditingControllerParcAddress: textEditingControllerParcAddress,
          function: functionForPrediction,
        ),
      ],
    );
  }
}
