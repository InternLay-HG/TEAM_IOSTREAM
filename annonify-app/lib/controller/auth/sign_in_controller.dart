import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final signInFormKey = GlobalKey<FormState>();

  //Textfield controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Obscure text controller
  final RxBool hidePassword = true.obs;
}
