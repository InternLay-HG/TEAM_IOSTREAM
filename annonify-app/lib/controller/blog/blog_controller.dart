import 'dart:convert';
import 'dart:io';
import 'package:annonify/models/blog/comment_model.dart';
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

  final RxList<PostModel> posts = <PostModel>[].obs;

  ////Add blog
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  var selectedImage = Rxn<File>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPosts();
  }

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
        refreshBlogs();
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

  Future<void> like(String postId) async {
    try {
      final url = Uri.parse('$server/posts/$postId/like');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        refreshBlogs();

        Get.snackbar("Success", "Post liked!");
      } else {
        final error = json.decode(response.body);
        Get.snackbar("Error", error['message'] ?? "Failed to like the post.");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  void clearFields() {
    titleController.clear();
    bodyController.clear();
    selectedImage.value = null;
  }

  //Fetch Posts
  Future<void> fetchPosts() async {
    try {
      final url = Uri.parse('$server/posts');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        posts.assignAll(data.map((json) => PostModel.fromJson(json)).toList());
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print(error);
      Get.snackbar("Error", "Failed to fetch posts.");
    }
  }

  Future<void> refreshBlogs() async {
    await fetchPosts();
  }

  ////Comments.............................................................
  final TextEditingController commentController = TextEditingController();

  // Add a comment to a post
  Future<void> addComment(String? postId) async {
    final url = Uri.parse('$server/comments');
    if (commentController.text.isEmpty) return;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': commentController.text,
          'postId': postId,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final newComment = CommentModel.fromJson(responseData);

        // Find the post and update its comments
        final index = posts.indexWhere((post) => post.id == postId);
        if (index != -1) {
          posts[index].comments.add(newComment);
          posts.refresh(); // Notify GetX to update UI
        }

        Get.snackbar("Success", "Comment added!");
        commentController.clear(); // Clear the input field after adding comment
      } else {
        final error = json.decode(response.body);
        Get.snackbar("Error", error['message'] ?? "Failed to add comment.");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    bodyController.dispose();
    commentController.dispose();
    super.onClose();
  }
}
