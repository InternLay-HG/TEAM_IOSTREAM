import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:annonify/models/blog/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
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

  Future<void> addBlog() async {
    final Map<String, String> body = {
      "title": titleController.text,
      "description": bodyController.text,
    };
    var request = http.MultipartRequest('POST', Uri.parse('$server/posts'));

    try {
      request.fields.addAll(body);
      if (selectedImage.value != null) {
        String contentType = 'image/jpeg'; // Default to JPEG
        final extension =
            selectedImage.value!.path.split('.').last.toLowerCase();
        if (extension == 'png') contentType = 'image/png';

        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage.value!.path,
          contentType: MediaType('image', extension),
        ));
      }

      var response = await request.send();
      // Handle multipart response body
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final responseData = json.decode(responseBody);
        posts.add(PostModel(
          name: "User",
          postTitle: titleController.text,
          postBody: bodyController.text,
          image: selectedImage.value,
        ));
        Get.snackbar("Success", "Blog added!");
        clearFields();
      } else {
        final error = json.decode(responseBody);
        Get.snackbar("Error", error['message'] ?? "failed");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
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
