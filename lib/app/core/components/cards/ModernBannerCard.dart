import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:cars/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/models/frombackend/adsmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModernBannerCard extends StatelessWidget {
  final AdsModel ad;
  final LinearGradient gradient;
  final HomeController controller;

  const ModernBannerCard({
    Key? key,
    required this.ad,
    required this.gradient,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!.withOpacity(0.1),
            blurRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => controller.onBannerTap(ad.title),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    ImagesAssetsConstants.voiture,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        MainColors.primaryColor.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      ad.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: MainColors.whiteColor,
                        shadows: [
                          Shadow(
                            color: MainColors.blackColor.withOpacity(0.54),
                            offset: Offset(1.w, 1.h),
                            blurRadius: 3.r,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      ad.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MainColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: MainColors.blackColor.withOpacity(0.54),
                            offset: Offset(1.w, 1.h),
                            blurRadius: 3.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
