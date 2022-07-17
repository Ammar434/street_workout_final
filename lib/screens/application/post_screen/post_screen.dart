import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_workout_final/screens/application/home_screen/parc_info/components/parc_info_equipment_available.dart';
import 'package:street_workout_final/services/image_picker.dart';
import 'package:street_workout_final/utils/constants.dart';
import 'package:street_workout_final/widgets/rounded_button.dart';
import 'package:street_workout_final/widgets/text_field_input_with_autocomplete.dart';

import 'components/add_photo.dart';
import 'components/parc_info_selectable_row.dart';

List<Uint8List> articleImageListe = [];

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late TextEditingController textEditingController;
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  selectImage() async {
    List<Uint8List> im = await pickMultipleImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      articleImageListe.addAll(im);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
          child: Column(
            children: [
              AddPhoto(
                function1: selectImage,
                function2: (index) {
                  setState(
                    () {
                      articleImageListe.removeAt(index);
                    },
                  );
                },
              ),
              TextFieldInputWithAutoComplete(
                textEditingController: textEditingController,
                rowName: 'Name',
                hintText: "Enter your parc name",
              ),
              TextFieldInputWithAutoComplete(
                textEditingController: textEditingController,
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
                    const ParcEquipmentSelectableRow()
                  ],
                ),
              ),
              RoundedButton(
                onTap: () {},
                text: "Publish",
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
