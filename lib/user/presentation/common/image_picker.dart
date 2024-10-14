
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetMultiplePictures {
  static List<XFile>? imageFileList = [];

  static Future<List<XFile>> selectImages() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    return imageFileList ?? [];
  }
}
