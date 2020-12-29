import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static final englishAppTheme = ThemeData(
    primaryColor: AppColors.blueAccent,
    primaryColorDark: AppColors.darkBluePrimary,
    accentColor: AppColors.blueAccent,
    iconTheme: iconTheme,
    scaffoldBackgroundColor: AppColors.white,
    accentIconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    hintColor: Colors.transparent,
    errorColor: AppColors.redError,
    fontFamily: "NunitoSans",
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
          color: AppColors.lightTextColor),
      headline3: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextColor),
      headline4: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.lightTextColor),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextColor),
      button: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w800,
          color: AppColors.lightTextColor),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextColor),
      bodyText2: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: AppColors.lightTextColor),
    ),
  );

  static final arabicAppTheme = ThemeData(
    primaryColor: AppColors.blueAccent,
    primaryColorDark: AppColors.darkBluePrimary,
    accentColor: AppColors.blueAccent,
    iconTheme: iconTheme,
    scaffoldBackgroundColor: AppColors.white,
    accentIconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    hintColor: Colors.transparent,
    errorColor: AppColors.redError,
    fontFamily: "Cairo",
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
          color: AppColors.lightTextColor),
      headline3: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextColor),
      headline4: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: AppColors.lightTextColor),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextColor),
      button: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w800,
          color: AppColors.lightTextColor),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextColor),
      bodyText2: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: AppColors.lightTextColor),
    ),
  );

  static final iconTheme = IconThemeData(color: AppColors.blueAccent);
  static get textTheme {
    return AppStrings.currentCode == CodeStrings.arabicCode
        ? arabicAppTheme.textTheme
        : englishAppTheme.textTheme;
  }
}
