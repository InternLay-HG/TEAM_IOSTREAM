import 'dart:io';

import 'package:annonify/models/blog/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  static BlogController get instance => Get.find();

  String? server = dotenv.env['uri'];

  final RxList<PostModel> posts = [
    PostModel(
      // avatar: avatarController.avatars[0].svgData,
      name: "house of Geeks",
      postTitle: "Happy Diwali to all IIITians",
      postBody:
          "While we’re busy debugging code and breaking things in production, Diwali arrives to remind us that not all lights are errors! 💡🎇 Let’s celebrate this festival with fewer bugs and more brightness (literally). May your code run without exceptions, and your projects compile with 0 warnings!  Happy Diwali from the sleep-deprived but ever-enthusiastic House of Geeks",
    ),
    PostModel(
      // avatar: avatarController.avatars[0].svgData,
      name: "house of Geeks",
      postTitle: "Happy Diwali to all IIITians",
      postBody:
          "While we’re busy debugging code and breaking things in production, Diwali arrives to remind us that not all lights are errors! 💡🎇 Let’s celebrate this festival with fewer bugs and more brightness (literally). May your code run without exceptions, and your projects compile with 0 warnings!Happy Diwali from the sleep-deprived but ever-enthusiastic House of Geeks",
    )
  ].obs;

  ////Add blog
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
      clearFields();
      Get.snackbar("No Image Selected", "Please select an image.");
    }
  }

  void addBlog() {
    posts.add(PostModel(
      name: "User",
      postTitle: titleController.text,
      postBody: bodyController.text,
      image: selectedImage.value,
    ));

    clearFields();
  }

  void like(PostModel post) {
    post.likes++;
    posts.refresh();
  }

  void clearFields() {
    titleController.clear();
    bodyController.clear();
    selectedImage.value = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
