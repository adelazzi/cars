import 'package:cars/app/core/constants/animations_assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/splash/controllers/splash_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.4, 0.7, 1.0],
            colors: [
              MainColors.primaryColor.withOpacity(0.8),
              MainColors.primaryColor,
              MainColors.primaryColor.withOpacity(0.9),
              Colors.black87,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(
              20,
              (index) => TweenAnimationBuilder(
                duration: Duration(seconds: 3 + (index % 3)),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Positioned(
                    left: (index * 50.0).w % MediaQuery.of(context).size.width,
                    top: value * MediaQuery.of(context).size.height +
                        (index * 30.0).h % 200.h,
                    child: Opacity(
                      opacity: (0.1 + (index % 3) * 0.1),
                      child: Container(
                        width: (4 + (index % 3) * 2).w,
                        height: (4 + (index % 3) * 2).h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
                onEnd: () => controller.update(), // Restart animation
              ),
            ),

            // Geometric background shapes
            Positioned(
              top: -100.h,
              right: -100.w,
              child: TweenAnimationBuilder(
                duration: Duration(seconds: 4),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.rotate(
                    angle: value * 2 * 3.14159,
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 2.w,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(
              bottom: -50.h,
              left: -50.w,
              child: TweenAnimationBuilder(
                duration: Duration(seconds: 5),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Transform.rotate(
                    angle: -value * 2 * 3.14159,
                    child: Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 1.5.w,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo container with glassmorphism effect
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20.r,
                          offset: Offset(0, 10.h),
                        ),
                      ],
                    ),
                    child: TweenAnimationBuilder(
                      duration: Duration(seconds: 2),
                      tween: Tween<double>(begin: 0.5, end: 1.0),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: Lottie.asset(
                              AnimationsAssetsConstants.carsAnimation,
                              width: 200.h,
                              height: 200.h,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // App name with modern typography
                  TweenAnimationBuilder(
                    duration: Duration(milliseconds: 1500),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30.h * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: Column(
                            children: [
                              Text(
                                'CARS',
                                style: TextStyle(
                                  fontSize: 42.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 8.sp,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 4.h),
                                      blurRadius: 8.r,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: 60.w,
                                height: 3.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.white.withOpacity(0.3),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Drive Your Dreams',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 2.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Loading indicator at bottom
            Positioned(
              bottom: 80.h,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 2000),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Column(
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: MainColors.whiteColor.withOpacity(0.7),
                          size: 40.w,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          StringsAssetsConstants.loadingExperience,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Version info
            Positioned(
              bottom: 20.h,
              right: 20.w,
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 2500),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
