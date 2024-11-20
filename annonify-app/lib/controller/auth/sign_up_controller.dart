import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final signUpFormKey = GlobalKey<FormState>();

  //TextField controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();

  //Obscure text controller
  final RxBool hidePassword = true.obs;
  final RxBool hideConfPassword = true.obs;

  String avatar = "";

  String? server = dotenv.env['uri'];

  void addAvatar(String name) {
    avatar = name;
  }

  Future<void> signUp() async {
    final Map<String, String> body = {
      'email': emailController.text,
      'password': passwordController.text,
      'name': nameController.text,
      'avatar': avatar,
    };
    try {
      if (!signUpFormKey.currentState!.validate()) {
        return;
      }

      final response = await http.post(
        Uri.parse('${server}signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        Get.snackbar("Success", "Signup successful!");
        //  navigate to the login screen
        Get.offAllNamed('/signin');
      } else {
        final error = json.decode(response.body);
        Get.snackbar("Error", error['message'] ?? "Signup failed");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // nameController.dispose();
    // passwordController.dispose();
    // confPassController.dispose();
    super.onClose();
  }
}
