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
                  Get.toNamed('/chooseAvatar');
                },
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 60)),
                ),
                child: const Text("SIGN UP"),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(child: Text("Already have an account?")),
                TextButton(
                  onPressed: () {
                    Get.offNamed('/signin');
                  },
                  child: const Text("LOGIN"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
