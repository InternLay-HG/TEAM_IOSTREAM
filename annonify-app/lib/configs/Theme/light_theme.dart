import 'package:annonify/configs/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: LightThemeColors.primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: LightThemeColors.primaryColor,
  iconTheme: const IconThemeData(color: LightThemeColors.textHeading),
  fontFamily:
      GoogleFonts.chakraPetch(color: LightThemeColors.textHeading).fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      color: LightThemeColors.textHeading,
    ),
    displayMedium: TextStyle(
      fontSize: 16,
      color: LightThemeColors.textSubHeading,
    ),
    displaySmall: TextStyle(
      fontSize: 14,
      color: LightThemeColors.secondaryTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      color: LightThemeColors.accentColor,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: LightThemeColors.textHeading,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: LightThemeColors.accentColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: LightThemeColors.textHeading,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      color: LightThemeColors.textSubHeading,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: LightThemeColors.primaryColor,
    centerTitle: true,
    titleTextStyle: TextStyle(color: LightThemeColors.textHeading),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: LightThemeColors.textHeading,
    indicatorColor: LightThemeColors.accentColor,
    unselectedLabelColor: LightThemeColors.textSubHeading,
    labelPadding: EdgeInsets.symmetric(vertical: 14),
    dividerColor: Colors.transparent,
  ),
  listTileTheme: const ListTileThemeData(
    selectedColor: LightThemeColors.highlightColor,
    selectedTileColor: LightThemeColors.highlightColor,
    titleTextStyle: TextStyle(
      color: LightThemeColors.textHeading,
      fontSize: 16,
    ),
    subtitleTextStyle: TextStyle(
      color: LightThemeColors.textSubHeading,
      fontSize: 14,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    hintStyle: TextStyle(
      fontSize: 14,
      color: LightThemeColors.textSubHeading,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: LightThemeColors.textHeading),
    ),
    suffixIconColor: LightThemeColors.textSubHeading,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          const WidgetStatePropertyAll(LightThemeColors.accentColor),
      foregroundColor:
          const WidgetStatePropertyAll(LightThemeColors.primaryColor),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontSize: 16,
        color: LightThemeColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.chakraPetch(color: LightThemeColors.textHeading)
            .fontFamily,
      )),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          const WidgetStatePropertyAll(LightThemeColors.accentColor),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontSize: 16,
        color: LightThemeColors.accentColor,
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.chakraPetch(color: LightThemeColors.textHeading)
            .fontFamily,
      )),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(LightThemeColors.accentColor),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightThemeColors.accentColor,
    shape: CircleBorder(),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: LightThemeColors.accentColor,
  ),
);
