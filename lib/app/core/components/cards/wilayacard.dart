import 'package:cars/app/core/constants/wilayas.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class wilayacard extends StatelessWidget {
  wilayacard({super.key, required this.wilaya});
  Wilaya wilaya;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70.w,
            width: 70.w,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: MainColors.primaryColor.withOpacity(0.3),
                    blurRadius: 10.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
                shape: BoxShape.circle,
                gradient: MainColors.primaryGradientColor),
            child: Center(
                child: Text(wilaya.num.toString(),
                    style: TextStyles.labelMedium(context)
                        .copyWith(color: MainColors.whiteColor))),
          ),
          SizedBox(height: 8.h),
          Text(
            wilaya.name,
            style: TextStyles.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
