import 'package:annonify/controller/auth/sign_in_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final ThemeController themeController = Get.find<ThemeController>();

    return Form(
      key: controller.signInFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor: themeController.textHeading,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              decoration: const InputDecoration(
                hintText: "E-mail",
              ),
              validator: (value) => Validator.validateEmail(value),
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                cursorColor: themeController.textHeading,
                obscureText: controller.hidePassword.value,
                controller: controller.passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                    child: Icon(controller.hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                validator: (value) => Validator.validatePassword(value),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.signin();
                },
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 60)),
                ),
                child: const Text("SIGN IN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
