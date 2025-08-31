import 'package:cars/app/core/components/inputs/imagepicker.dart';
import 'package:cars/app/core/components/inputs/text_input_component_labelinborder.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/modules/register/controllers/register_controller.dart';

import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              MainColors.primaryColor.withOpacity(0.5),
              MainColors.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              // Welcome Text
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      StringsAssetsConstants.joinUsToday,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: MainColors.textColor(context),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      StringsAssetsConstants.createYourAccountToGetStarted,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: MainColors.textColor(context)?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              CustomImagePicker(
                onImageSelected: (File) {
                  controller.selectedImage.value = File;
                },
              ),

              SizedBox(height: 32.h),
              // Form Fields
              TextInputComponentWithLabelInBorder(
                controller: controller.nameController,
                label: StringsAssetsConstants.firstName,
                hint: StringsAssetsConstants.enterYourFirstName,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: MainColors.primaryColor,
                ),
              ),

              SizedBox(height: 16.h),

              TextInputComponentWithLabelInBorder(
                controller: controller.famelynameController,
                label: StringsAssetsConstants.familyName,
                hint: StringsAssetsConstants.enterYourFamilyName,
                prefixIcon: Icon(
                  Icons.family_restroom,
                  color: MainColors.primaryColor,
                ),
              ),

              SizedBox(height: 16.h),

              TextInputComponentWithLabelInBorder(
                controller: controller.phonenumberController,
                label: StringsAssetsConstants.phoneNumber,
                hint: StringsAssetsConstants.enterYourPhoneNumber,
                textInputType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.phone,
                  color: MainColors.primaryColor,
                ),
              ),

              SizedBox(height: 16.h),

              TextInputComponentWithLabelInBorder(
                controller: controller.adressController,
                label: StringsAssetsConstants.address,
                hint: StringsAssetsConstants.enterYourAddress,
                maxLines: 2,
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: MainColors.primaryColor,
                ),
              ),

              SizedBox(height: 32.h),

              // Register Button
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 1000),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: MainColors.primaryGradientColor,
                        borderRadius: BorderRadius.circular(28.r),
                        boxShadow: [
                          BoxShadow(
                            color: MainColors.primaryColor.withOpacity(0.3),
                            blurRadius: 20.r,
                            offset: Offset(0, 10.h),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.handleRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add,
                              color: MainColors.whiteColor,
                              size: 18.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              StringsAssetsConstants.createAccount,
                              style: TextStyle(
                                color: MainColors.whiteColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 24.h),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringsAssetsConstants.alreadyHaveAnAccount,
                    style: TextStyle(
                      color: MainColors.textColor(context)?.withOpacity(0.7),
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Navigate back to login
                    },
                    child: Text(
                      StringsAssetsConstants.signIn,
                      style: TextStyle(
                        color: MainColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
