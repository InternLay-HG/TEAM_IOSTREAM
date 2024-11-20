import 'package:annonify/controller/auth/sign_up_controller.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:annonify/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final ThemeController themeController = Get.find<ThemeController>();

    return Form(
      key: controller.signUpFormKey,
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
            TextFormField(
              cursorColor: themeController.textHeading,
              controller: controller.nameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                cursorColor: themeController.textHeading,
                obscureText: controller.hidePassword.value,
                controller: controller.passwordController,
                validator: (value) => Validator.validatePassword(value),
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
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => TextFormField(
                cursorColor: themeController.textHeading,
                obscureText: controller.hideConfPassword.value,
                controller: controller.confPassController,
                validator: (value) => Validator.validatePassword(value),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.hideConfPassword.value =
                          !controller.hideConfPassword.value;
                    },
                    child: Icon(controller.hideConfPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.signUp();
                },
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 60)),
                ),
                child: const Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
