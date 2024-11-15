import 'package:annonify/configs/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final RxBool isDark = true.obs;

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  //Theme Colors
  Color get contentBG =>
      (isDark.value) ? DarkThemeColors.contentBG : LightThemeColors.contentBG;

  Color get primaryColor => (isDark.value)
      ? DarkThemeColors.primaryColor
      : LightThemeColors.primaryColor;

  Color get textHeading => (isDark.value)
      ? DarkThemeColors.textHeading
      : LightThemeColors.textHeading;

  Color get textSubHeading => (isDark.value)
      ? DarkThemeColors.textSubHeading
      : LightThemeColors.textSubHeading;

  Color get secondaryTextColor => (isDark.value)
      ? DarkThemeColors.secondaryTextColor
      : LightThemeColors.secondaryTextColor;

  Color get highlightColor => (isDark.value)
      ? DarkThemeColors.highlightColor
      : LightThemeColors.highlightColor;

  Color get postButtonColor => (isDark.value)
      ? DarkThemeColors.postButtonColor
      : LightThemeColors.postButtonColor;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}
