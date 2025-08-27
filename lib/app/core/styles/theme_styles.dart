// ignore_for_file: deprecated_member_use

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';

class ThemeStyles {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MainColors.primaryColor,
    scaffoldBackgroundColor: LightColors.backgroundColor,
    shadowColor: LightColors.shadowColor,
    splashColor: MainColors.primaryColor.withOpacity(0.3),
    highlightColor: MainColors.primaryColor.withOpacity(0.2),
    appBarTheme: AppBarTheme(
      elevation: 1,
      shadowColor: LightColors.shadowColor,
      centerTitle: true,
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: LightColors.textColor,
      ),
      titleTextStyle: TextStyle(
        color: LightColors.textColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: LightColors.backgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.primaryColor,
        foregroundColor: MainColors.whiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: LightColors.inputColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: MainColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: LightColors.errorColor),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: MainColors.primaryColor,
      secondary: MainColors.secondaryColor,
      background: LightColors.backgroundColor,
      error: LightColors.errorColor,
      surface: MainColors.whiteColor,
    ),
    extensions: <ThemeExtension<dynamic>>[
      const ColorsStyles(
        backgroundColor: LightColors.backgroundColor,
        textColor: LightColors.textColor,
        disableColor: LightColors.disableColor,
        errorColor: LightColors.errorColor,
        infoColor: LightColors.infoColor,
        inputColor: LightColors.inputColor,
        successColor: LightColors.successColor,
        warningColor: LightColors.warningColor,
        shadowColor: LightColors.shadowColor,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MainColors.primaryColor,
    scaffoldBackgroundColor: DarkColors.backgroundColor,
    shadowColor: DarkColors.shadowColor,
    splashColor: MainColors.primaryColor.withOpacity(0.3),
    highlightColor: MainColors.primaryColor.withOpacity(0.2),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      shadowColor: DarkColors.shadowColor,
      surfaceTintColor: DarkColors.backgroundColor,
      iconTheme: const IconThemeData(
        color: DarkColors.textColor,
      ),
      titleTextStyle: TextStyle(
        color: DarkColors.textColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: DarkColors.backgroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.primaryColor,
        foregroundColor: MainColors.whiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: DarkColors.inputColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: MainColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: DarkColors.errorColor),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: MainColors.primaryColor,
      secondary: MainColors.secondaryColor,
      background: DarkColors.backgroundColor,
      error: DarkColors.errorColor,
      surface: DarkColors.inputColor,
    ),
    extensions: <ThemeExtension<dynamic>>[
      const ColorsStyles(
        backgroundColor: DarkColors.backgroundColor,
        textColor: DarkColors.textColor,
        disableColor: DarkColors.disableColor,
        errorColor: DarkColors.errorColor,
        infoColor: DarkColors.infoColor,
        inputColor: DarkColors.inputColor,
        successColor: DarkColors.successColor,
        warningColor: DarkColors.warningColor,
        shadowColor: DarkColors.shadowColor,
      ),
    ],
  );
}
