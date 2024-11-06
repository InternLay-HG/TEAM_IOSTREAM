import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Media extends StatelessWidget {
  const Media({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Container(
      decoration: BoxDecoration(
        color: themeController.contentBG,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }
}
