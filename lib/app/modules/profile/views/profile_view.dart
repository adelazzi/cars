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
import 'package:shimmer/shimmer.dart';

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
            ? _buildLoadingShimmer(context)
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(context),
                    Wrap(
                      children: usercontroller.currentUser.value.brands != null
                          ? usercontroller.currentUser.value.brands!
                              .map((brand) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 4.h),
                                    child: Chip(
                                      label: Text(brand.name),
                                      avatar: brand.image.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(brand.image),
                                            )
                                          : null,
                                    ),
                                  ))
                              .toList()
                          : [],
                    ),
                    MyCarsSection(
                      cars: controller.cars,
                      onAddCar: () => controller.navigateToAddCar(),
                      onCarTap: (index) =>
                          controller.navigateToDetailsCar(index),
                    ),
                    SizedBox(height: 20.h),
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

  Widget _buildLoadingShimmer(BuildContext context) {
    final base = (MainColors.shadowColor(context) ??
            Theme.of(context).colorScheme.surface)
        .withOpacity(0.8);
    final highlight = (MainColors.inputColor(context) ??
            Theme.of(context).colorScheme.onSurface)
        .withOpacity(0.06);
    final placeholder = MainColors.inputColor(context) ?? Colors.grey[300];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Column(
            children: [
              // header shimmer
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context) ??
                      Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 220.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: placeholder,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 20.h, width: 140.w, color: placeholder),
                          SizedBox(height: 8.h),
                          Container(
                              height: 20.h, width: 100.w, color: placeholder),
                          SizedBox(height: 8.h),
                          Container(
                              height: 20.h, width: 180.w, color: placeholder),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // chips shimmer
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (_, __) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: placeholder,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    width: 80.w,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // car items shimmer
              Column(
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: MainColors.backgroundColor(context) ??
                          Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 60.h,
                          width: 90.w,
                          color: placeholder,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 14.h,
                                  width: double.infinity,
                                  color: placeholder),
                              SizedBox(height: 8.h),
                              Container(
                                  height: 12.h,
                                  width: 120.w,
                                  color: placeholder),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
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
                          fit: BoxFit.cover,
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
                        size: 40.sp,
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
                              color: MainColors.backgroundColor(context) ??
                                  Theme.of(context).colorScheme.surface,
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
                  ('${usercontroller.currentUser.value.firstName!} ${usercontroller.currentUser.value.lastName!}') ??
                      'User',
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
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(Icons.star, size: 20.sp, color: Colors.amber),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        child: Text(
                          usercontroller.currentUser.value.rating.toString() ??
                              '0.0',
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
