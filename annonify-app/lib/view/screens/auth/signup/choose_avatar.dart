import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/avatar_controller.dart';
import 'package:annonify/controller/auth/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({super.key});

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  @override
  Widget build(BuildContext context) {
    final AvatarController avatarController = Get.find<AvatarController>();
    final SignUpController signUpController = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
          const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "CHOOSE YOUR AVATAR",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: DarkThemeColors.accentColor,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Obx(() {
                  if (avatarController.avatars.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing:
                      (MediaQuery
                          .of(context)
                          .size
                          .width - 50) * 0.04,
                      mainAxisSpacing:
                      (MediaQuery
                          .of(context)
                          .size
                          .width - 50) * 0.04,
                    ),
                    itemCount: avatarController.avatars.length,
                    itemBuilder: (context, index) {
                      final avatar = avatarController.avatars[index];

                      return InkWell(
                        onTap: () {
                          avatarController.selectAvatar(avatar.name);
                        },
                        child: Obx(() {
                          return CircleAvatar(
                            backgroundColor: (avatarController
                                .selectedAvatar.value ==
                                avatar.name)
                                ? DarkThemeColors.accentColor.withOpacity(0.5)
                                : Colors.transparent,
                            child: avatar.svgData != null
                                ? SvgPicture.string(
                                (avatar.svgData)!.replaceAll(
                                    RegExp(
                                        r'<metadata[^>]*>(.|\n)*?</metadata>'),
                                    ''))
                                : const CircularProgressIndicator(),
                          );
                        }),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: const Alignment(1, 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (avatarController.selectedAvatar.value.isNotEmpty) {
                      signUpController.avatar =
                          avatarController.selectedAvatar.value;
                      Get.toNamed('/signup');
                    } else {
                      Get.snackbar("Selection Required",
                          "Please select an avatar before continuing.");
                    }
                  },
                  child: const Text("Continue"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
