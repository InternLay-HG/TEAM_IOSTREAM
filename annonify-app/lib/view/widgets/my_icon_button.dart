import 'package:annonify/configs/Theme/colors.dart';
import 'package:annonify/controller/app/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    Color textHeading = (themeController.isDark.value)
        ? DarkThemeColors.textHeading
        : LightThemeColors.textHeading;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: DarkThemeColors.accentColor,
            borderRadius: BorderRadius.circular(16)),
        child: Icon(
          icon,
          color: textHeading,
        ),
      ),
    );
  }
}
