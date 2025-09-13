import 'package:cars/app/core/components/bottoms/primary_button_component.dart';
import 'package:cars/app/core/components/inputs/imagepicker.dart';
import 'package:cars/app/core/components/inputs/text_input_component_labelinborder.dart';
import 'package:cars/app/core/components/others/languagebottomsheet.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/text_styles.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MainColors.primaryColor.withOpacity(0.1),
              MainColors.primaryColor.withOpacity(0.05),
              Colors.white,
              MainColors.primaryColor.withOpacity(0.08),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated background elements
              Positioned(
                top: -50.h,
                right: -50.w,
                child: TweenAnimationBuilder(
                  duration: const Duration(seconds: 20),
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
                            color: MainColors.primaryColor.withOpacity(0.1),
                            width: 1.w,
                          ),
                        ),
                      ),
                    );
                  },
                  onEnd: () => controller.update(),
                ),
              ),

              Positioned(
                bottom: -100.h,
                left: -80.w,
                child: TweenAnimationBuilder(
                  duration: const Duration(seconds: 15),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.rotate(
                      angle: -value * 2 * 3.14159,
                      child: Container(
                        width: 300.w,
                        height: 300.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: MainColors.primaryColor.withOpacity(0.08),
                            width: 1.w,
                          ),
                        ),
                      ),
                    );
                  },
                  onEnd: () => controller.update(),
                ),
              ),

              // Main content
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),

                      // Header section
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.translate(
                            offset: Offset(0, 50.h * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: Column(
                                children: [
                                  // App logo/icon
                                  Container(
                                    width: 80.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          MainColors.primaryColor,
                                          MainColors.primaryColor
                                              .withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: MainColors.primaryColor
                                              .withOpacity(0.3),
                                          blurRadius: 20.r,
                                          offset: Offset(0, 10.h),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.directions_car_rounded,
                                      size: 40.sp,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(height: 24.h),

                                  Text(
                                    StringsAssetsConstants.welcomeBack,
                                    style: TextStyles.titleLarge(context),
                                  ),

                                  SizedBox(height: 8.h),

                                  Text(
                                    StringsAssetsConstants.signInToContinue,
                                    style: TextStyles.bodyMedium(context)
                                        .copyWith(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 50.h),

                      // Login form
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 1200),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.translate(
                            offset: Offset(0, 30.h * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 50.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 30.r,
                                      offset: Offset(0, 15.h),
                                    ),
                                    BoxShadow(
                                      color: MainColors.primaryColor
                                          .withOpacity(0.05),
                                      blurRadius: 60.r,
                                      offset: Offset(0, 30.h),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Email field
                                    TextInputComponentWithLabelInBorder(
                                      controller: controller.emailController,
                                      label:
                                          StringsAssetsConstants.emailAddress,
                                      hint: StringsAssetsConstants.enterEmail,
                                      textInputType: TextInputType.emailAddress,
                                    ),

                                    SizedBox(height: 20.h),

                                    // Password field
                                    Obx(() =>
                                        TextInputComponentWithLabelInBorder(
                                          controller:
                                              controller.passwordController,
                                          label:
                                              StringsAssetsConstants.password,
                                          hint: StringsAssetsConstants
                                              .enterPassword,
                                          obscureText:
                                              controller.isPasswordHidden.value,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              controller.isPasswordHidden.value
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: Colors.black54,
                                            ),
                                            onPressed: controller
                                                .togglePasswordVisibility,
                                          ),
                                          onChanged: (value) =>
                                              controller.password = value,
                                        )),

                                    SizedBox(height: 10.h),

                                    // Remember me & Forgot password
                                    TextButton(
                                      onPressed: () {
                                        // Handle forgot password
                                      },
                                      child: Text(
                                        StringsAssetsConstants.forgotPassword,
                                        style: TextStyles.bodyMedium(context)
                                            .copyWith(
                                          color: MainColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 32.h),

                                    // Login button
                                    PrimaryButtonComponent(
                                      onTap: () {
                                        // Handle login
                                        controller.login();
                                      },
                                      text: StringsAssetsConstants.signIn,
                                      isLoading: controller.isLoading.value,
                                      height: 56.h,
                                      width: double.infinity,
                                      borderRadius: BorderRadius.circular(16.r),
                                      gradient: LinearGradient(
                                        colors: [
                                          MainColors.primaryColor,
                                          MainColors.primaryColor
                                              .withOpacity(0.8),
                                        ],
                                      ),
                                      boxShadow: BoxShadow(
                                        color: MainColors.primaryColor
                                            .withOpacity(0.4),
                                        blurRadius: 20.r,
                                        offset: Offset(0, 10.h),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 40.h),

                      // Sign up section
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 2000),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  StringsAssetsConstants.dontHaveAccount,
                                  style: TextStyles.bodySmall(context)
                                      .copyWith(color: Colors.black54),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.REGISTER);
                                  },
                                  child: Text(
                                    StringsAssetsConstants.signUp,
                                    style:
                                        TextStyles.bodySmall(context).copyWith(
                                      color: MainColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 20.h,
                right: 30.w,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                      ),
                      builder: (context) => const LanguageBottomSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MainColors.backgroundColor(context),
                      boxShadow: [
                        BoxShadow(
                          color:
                              MainColors.shadowColor(context)!.withOpacity(0.2),
                          blurRadius: 4.r,
                          spreadRadius: 2,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.language,
                      color: MainColors.primaryColor,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
