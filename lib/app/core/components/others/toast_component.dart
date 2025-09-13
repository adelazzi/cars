// ignore_for_file: deprecated_member_use

import 'package:cars/app/core/constants/icons_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class ToastComponent {
  void showToast(BuildContext context,
      {required String message,
      required ToastTypes type,
      double? bottomMessage}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 12.r,
      // margin: EdgeInsets.all(10.r),
      margin: EdgeInsets.only(
          bottom: bottomMessage ?? 10.r, left: 20.h, right: 20.h),

      duration: const Duration(milliseconds: 2000),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: type == ToastTypes.error
          ? MainColors.errorColor(context)
          : type == ToastTypes.success
              ? MainColors.successColor(context)
              : type == ToastTypes.info
                  ? MainColors.primaryColor
                  : type == ToastTypes.copies
                      ? MainColors.blackColor.withOpacity(0.2)
                      : MainColors.secondaryColor,
      isDismissible: true,
      titleText: const Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      boxShadows: [
        BoxShadow(
          color: MainColors.textColor(context)!.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 20.r,
          offset: const Offset(0, 0),
        ),
      ],
      padding: EdgeInsets.only(
        bottom: 20.h,
        top: 10.h,
        left: 25.w,
        right: 25.w,
      ),
      messageText: Row(
        children: [
          Icon(
            type == ToastTypes.success
                ? FontAwesomeIcons.check
                : type == ToastTypes.error
                    ? FontAwesomeIcons.xmark
                    : type == ToastTypes.info || type == ToastTypes.copies
                        ? FontAwesomeIcons.circleInfo
                        : FontAwesomeIcons.circleExclamation,
            color: Colors.white,
            size: 20.r,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: Get.width - 115,
            child: Text(
              message,
              style: TextStyles.bodyMedium(context).copyWith(
                color: MainColors.whiteColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

enum ToastTypes { success, error, info, warning, copies }
