import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/utils/translation_util.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Language',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          _buildLanguageOption(
            language: 'English',
            onTap: () {
              TranslationUtil.changeLang(lang: TranslationLanguages.english);
              Get.back(); // Close the bottom sheet
            },
            image: ImagesAssetsConstants.enLangIcon,
          ),
          _buildLanguageOption(
            language: 'Arabic',
            onTap: () {
              TranslationUtil.changeLang(lang: TranslationLanguages.arabic);
              Get.back(); // Close the bottom sheet
            },
            image: ImagesAssetsConstants.arLangIcon,
          ),
          _buildLanguageOption(
            language: 'French',
            onTap: () {
              TranslationUtil.changeLang(lang: TranslationLanguages.french);
              Get.back(); // Close the bottom sheet
            },
            image: ImagesAssetsConstants.frLangIcon,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required String language,
    required VoidCallback onTap,
    required String image,
  }) {
    final isSelected = TranslationUtil.currentLang ==
        Locale(language.substring(0, 2).toLowerCase());

    return ListTile(
      selectedColor: MainColors.primaryColor,
      selected: isSelected,
      leading: Container(
        width: 50.w,
        height: 50.w,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
          gradient: isSelected
              ? MainColors.primaryGradientColor
              : LinearGradient(
                  colors: [Colors.grey.shade300, Colors.grey.shade400],
                ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.contain),
          ),
        ),
      ),
      title: Text(
        language,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isSelected ? MainColors.primaryColor : Colors.black,
        ),
      ),
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: isSelected ? MainColors.primaryColor : Colors.grey,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
