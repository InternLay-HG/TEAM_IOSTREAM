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

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confPassController.dispose();
    super.onClose();
  }
}
