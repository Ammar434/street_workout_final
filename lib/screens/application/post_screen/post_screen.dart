import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:street_workout_final/models/material_available.dart';
import 'package:street_workout_final/provider/user_provider.dart';
import 'package:street_workout_final/services/image_picker.dart';
import 'package:street_workout_final/services/firestore_methods.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/snackbar.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/text_field_input_with_autocomplete.dart';

import 'components/add_photo.dart';
import 'components/parc_info_selectable_row.dart';

List userSelectedImageList = [];

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static String name = "PostScreen";
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late TextEditingController textEditingControllerParcName;
  late TextEditingController textEditingControllerParcAddress;
  List<MaterialAvailable> selectedMaterial = [];
  int selectedCard = -1;
  bool isLoading = false;

  Future<void> publishPost(
      {required String parcName,
      required String parcAddress,
      required String uid}) async {
    String title = "";
    String content = "";
    ContentType contentType;
    try {
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(
        listFile: userSelectedImageList,
        parcName: parcName,
        parcAddress: parcAddress,
        materialAvailable: selectedMaterial,
        uid: uid,
      );
      setState(() {
        isLoading = false;
      });
      if (res == "success") {
        title = "Posted";
        content =
            "We will examine your content quickly if all is ok we will show it quickly";
        contentType = ContentType.success;
      } else {
        title = "Error";
        content = "Sommething went wrong please retry to post";
        contentType = ContentType.failure;
      }
    } catch (e) {
      title = "Error";
      content = e.toString();
      contentType = ContentType.failure;
    }

    userSelectedImageList = [];
    selectedMaterial = [];
    textEditingControllerParcAddress.clear();
    textEditingControllerParcName.clear();

    showSnackBar(
      context: context,
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
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: kDefaultIconAppBar,
            ),
          ),
        ),
        title: const Text("Add new parc"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
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
              TextFieldInputWithAutoComplete(
                textEditingController: textEditingControllerParcName,
                rowName: 'Name',
                hintText: "Enter your parc name",
              ),
              TextFieldInputWithAutoComplete(
                textEditingController: textEditingControllerParcAddress,
                rowName: 'Address',
                hintText: "Enter your parc address",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingValue),
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
                          icon: const FaIcon(
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
                onTap: () => publishPost(
                  parcName: textEditingControllerParcName.text,
                  parcAddress: textEditingControllerParcAddress.text,
                  uid: userProvider.getUser.uid,
                ),
                text: "Publish",
                isLoading: isLoading,
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
