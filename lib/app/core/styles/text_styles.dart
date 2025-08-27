import 'package:cars/app/core/constants/fonts_family_assets_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class TextStyles {
  // Body text styles with different sizes
  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        overflow: TextOverflow.clip,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontSize: 15.sp,
        overflow: TextOverflow.clip,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: 17.sp,
        overflow: TextOverflow.clip,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  // Label text styles with different sizes (bold)
  static TextStyle labelSmall(BuildContext context) => TextStyle(
        height: 1.72,
        fontSize: 15.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle labelMedium(BuildContext context) => TextStyle(
        fontSize: 20.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle labelLarge(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  // Title text styles with different sizes
  static TextStyle titleSmall(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle titleMedium(BuildContext context) => TextStyle(
        fontSize: 28.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  static TextStyle titleLarge(BuildContext context) => TextStyle(
        fontSize: 36.sp,
        overflow: TextOverflow.ellipsis,
        fontFamily: FontsFamilyAssetsConstants.bold,
        fontWeight: FontWeight.bold,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);

  // Button specific style
  static TextStyle button(BuildContext context) => TextStyle(
        fontSize: 15.sp,
        overflow: TextOverflow.clip,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
      ).apply(fontSizeFactor: 1.0);
}
