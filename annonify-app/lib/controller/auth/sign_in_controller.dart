import 'dart:convert';
import 'package:annonify/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final signInFormKey = GlobalKey<FormState>();

  //TextField controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Obscure text controller
  final RxBool hidePassword = true.obs;

  String? server = dotenv.env['uri'];

  final AuthService authService = Get.find<AuthService>();

  Future<void> signin() async {
    final Map<String, String> body = {
      'email': emailController.text,
      'password': passwordController.text
    };
    try {
      if (!signInFormKey.currentState!.validate()) {
        return;
      }
      final response = await http.post(
        Uri.parse('${server}login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // print("login1");

        if (responseData['success']) {
          // print("login2");
          final userId = responseData['data']['userId'];
          final token = responseData['data']['token'];

          // Save userId and token
          await authService.saveLoginData(userId, token);

          Get.snackbar('Success', responseData['message']);
          Get.offAllNamed('/home'); // Navigate to HomePage
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Login failed');
        }
      } else {
        // Handle failure
        Get.snackbar("Error", "Invalid credentials or server error.");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
