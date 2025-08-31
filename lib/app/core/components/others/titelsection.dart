import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onpressed;
  const TitleSection({
    Key? key,
    this.onpressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.titleSmall(Get.context!),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyles.bodySmall(Get.context!),
                ),
            ],
          ),
          TextButton(
            onPressed: onpressed,
            child: Text(
              'See All',
              style: TextStyles.bodyMedium(Get.context!).copyWith(
                color: MainColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}