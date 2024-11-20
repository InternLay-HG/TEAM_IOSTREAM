import 'package:annonify/configs/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: DarkThemeColors.primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeColors.primaryColor,
  iconTheme: const IconThemeData(color: DarkThemeColors.textHeading),
  fontFamily:
      GoogleFonts.chakraPetch(color: DarkThemeColors.textHeading).fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      color: DarkThemeColors.textHeading,
    ),
    displayMedium: TextStyle(
      fontSize: 16,
      color: DarkThemeColors.textSubHeading,
    ),
    displaySmall: TextStyle(
      fontSize: 14,
      color: DarkThemeColors.secondaryTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 28,
      color: DarkThemeColors.accentColor,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: DarkThemeColors.textHeading,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: DarkThemeColors.accentColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: DarkThemeColors.textHeading,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      color: DarkThemeColors.textSubHeading,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: DarkThemeColors.primaryColor,
    centerTitle: true,
    titleTextStyle: TextStyle(color: DarkThemeColors.textHeading),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: DarkThemeColors.textHeading,
    indicatorColor: DarkThemeColors.accentColor,
    unselectedLabelColor: DarkThemeColors.textSubHeading,
    labelPadding: EdgeInsets.symmetric(vertical: 14),
    dividerColor: Colors.transparent,
  ),
  listTileTheme: const ListTileThemeData(
    selectedColor: DarkThemeColors.highlightColor,
    selectedTileColor: DarkThemeColors.highlightColor,
    titleTextStyle: TextStyle(
      color: DarkThemeColors.textHeading,
      fontSize: 16,
    ),
    subtitleTextStyle: TextStyle(
      color: DarkThemeColors.textSubHeading,
      fontSize: 14,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    hintStyle: TextStyle(
      fontSize: 14,
      color: DarkThemeColors.textSubHeading,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: DarkThemeColors.textHeading),
    ),
    suffixIconColor: DarkThemeColors.textSubHeading,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          const WidgetStatePropertyAll(DarkThemeColors.accentColor),
      foregroundColor:
          const WidgetStatePropertyAll(DarkThemeColors.primaryColor),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontSize: 16,
        color: DarkThemeColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.chakraPetch(color: DarkThemeColors.textHeading)
            .fontFamily,
      )),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          const WidgetStatePropertyAll(DarkThemeColors.accentColor),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontSize: 16,
        color: DarkThemeColors.accentColor,
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.chakraPetch(color: DarkThemeColors.textHeading)
            .fontFamily,
      )),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(DarkThemeColors.accentColor),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkThemeColors.accentColor,
    shape: CircleBorder(),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: DarkThemeColors.accentColor,
  ),
);
