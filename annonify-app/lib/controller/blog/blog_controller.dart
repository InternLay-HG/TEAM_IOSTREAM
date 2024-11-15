import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  static BlogController get instance => Get.find();

  //Add blog
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  var selectedImage = Rxn<File>();

  // Function to pick an image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    } else {
      Get.snackbar("No Image Selected", "Please select an image.");
    }
  }

  void clearFields() {
    titleController.clear();
    bodyController.clear();
    selectedImage.value = null;
  }
}
