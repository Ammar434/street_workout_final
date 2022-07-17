import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  debugPrint('No Image Selected');
}

pickMultipleImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? file = await imagePicker.pickMultiImage(
    imageQuality: 70,
    maxWidth: 1440,
  );
  if (file!.length > 10) {
    debugPrint("To much image");
    return;
  }
  List<Uint8List> list = [];
  for (int i = 0; i < file.length; i++) {
    list.add(await file[i].readAsBytes());
  }
  // print('No Image Selected');

  return list;
}
