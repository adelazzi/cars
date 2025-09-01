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
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MainColors.backgroundColor(context),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyles.titleMedium(context)
              .copyWith(color: MainColors.primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: MainColors.primaryColor),
            onPressed: () {
              controller.refreshProfile();
              usercontroller.setUser();
            },
          ),
        ],
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
                    navigateToFavorites: () => controller.navigateToFavorites(),
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
              usercontroller.currentUser.value.imageProfileUrl != null
                  ? CircleAvatar(
                      radius: 40.r,
                      backgroundColor: MainColors.primaryColor.withOpacity(0.2),
                      backgroundImage: NetworkImage(
                          usercontroller.currentUser.value.imageProfileUrl!
                          // ?? StringsAssets.defaultAvatar
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
                    onPressed: () => controller.updateProfilePicture(),
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
                  '${usercontroller.currentUser.value.name ?? 'User'} ${usercontroller.currentUser.value.familyName ?? ''}',
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
                      child: Text(
                        usercontroller.currentUser.value.address ??
                            'Add address',
                        style: TextStyles.bodySmall(context),
                        overflow: TextOverflow.ellipsis,
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
}
