import 'dart:io';

import 'package:cars/app/core/components/inputs/imagepicker.dart';
import 'package:cars/app/modules/profile/views/sections/accountoptionsection.dart';
import 'package:cars/app/modules/profile/views/sections/mycarssection.dart';
import 'package:cars/app/modules/profile/views/sections/quickqctionsection.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final usercontroller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshProfile(),
      child: Scaffold(
        backgroundColor: MainColors.backgroundColor(context),
        appBar: AppBar(
          actions: [
            usercontroller.currentUser.value.verified
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Icon(Icons.verified,
                        size: 30.sp, color: MainColors.primaryColor),
                  )
                : Container(),
          ],
          elevation: 0,
          backgroundColor: MainColors.backgroundColor(context),
          centerTitle: true,
          title: Text(
            'My Profile',
            style: TextStyles.titleMedium(context)
                .copyWith(color: MainColors.primaryColor),
          ),
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(context),
                    const SizedBox(height: 20),
                    QuickActionSection(
                      navigateToCars: () => controller.navigateToCars(),
                      navigateToMaintenance: () =>
                          controller.navigateToMaintenance(),
                      navigateToFavorites: () =>
                          controller.navigateToFavorites(),
                      navigateToHistory: () => controller.navigateToHistory(),
                    ),
                    const SizedBox(height: 20),
                    MyCarsSection(
                      cars: controller.cars,
                      onSeeAll: () => controller.navigateToCars(),
                      onAddCar: () => controller.navigateToAddCar(),
                      onCarTap: (index) => controller.navigateToEditCar(index),
                    ),
                    const SizedBox(height: 20),
                    AccountOptionSection(
                      onPaymentMethods: () =>
                          controller.navigateToPaymentMethods(),
                      onSupport: () => controller.navigateToSupport(),
                      onAbout: () => controller.navigateToAbout(),
                      onLogout: () => controller.logout(),
                    ),
                  ],
                ),
              )),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Stack(
            children: [
              usercontroller.currentUser.value.profileImage != null &&
                      usercontroller.currentUser.value.profileImage!.isNotEmpty
                  ? Container(
                      height: 120.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            usercontroller.currentUser.value.profileImage!,
                          ),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                        color: MainColors.primaryColor.withOpacity(0.2),
                      ),
                    )
                  : CircleAvatar(
                      radius: 40.r,
                      backgroundColor: MainColors.primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        color: MainColors.whiteColor,
                      ),
                    ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: MainColors.primaryColor,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.camera_alt,
                        size: 15.sp, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.r),
                              ),
                            ),
                            child: CustomImagePicker(
                              onImageSelected: (File image) {
                                // Show a confirmation dialog before updating profile picture
                                Get.defaultDialog(
                                  title: 'Confirm Update',
                                  content: Column(
                                    children: [
                                      Container(
                                        height: 150.h,
                                        width: 150.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: FileImage(image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                          'Are you sure you want to update your profile picture?'),
                                    ],
                                  ),
                                  textConfirm: 'Update',
                                  textCancel: 'Cancel',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Get.back(); // Close dialog
                                    controller.updateProfilePicture(image.path);
                                    controller.isLoading.value = true;
                                    usercontroller.RefreshUserData();
                                    controller.isLoading.value = false;
                                    Get.back();
                                  },
                                  onCancel: () {
                                    Get.back(); // Close dialog
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usercontroller.currentUser.value.name ?? 'User',
                  style: TextStyles.titleMedium(context),
                ),
                SizedBox(height: 5.h),
                Text(
                  usercontroller.currentUser.value.phoneNumber ??
                      'Add phone number',
                  style: TextStyles.bodySmall(context),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16.sp, color: MainColors.primaryColor),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        child: Text(
                          _formatLocation(usercontroller.currentUser.value),
                          style: TextStyles.bodySmall(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatLocation(dynamic user) {
    if (user.address != null && user.address!.isNotEmpty) {
      String location = user.address!;
      if (user.commune != null && user.commune!.isNotEmpty) {
        location += ', ${user.commune}';
      }
      if (user.wilaya != null && user.wilaya!.isNotEmpty) {
        location += ', ${user.wilaya}';
      }
      return location;
    }
    return 'Add address';
  }
}
