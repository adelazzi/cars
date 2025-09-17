import 'dart:developer';
import 'package:cars/app/core/components/others/toast_component.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Car> cars = <Car>[].obs;

  // Add your controller logic here

  void onLogout() {
    // Implement logout functionality
    print('User logged out');
  }

  void refreshProfile() {
    // Implement profile refresh functionality
    Get.find<UserController>().RefreshUserData();
    fetchMyCars();

    refresh();
    log('Profile refreshed');
  }

  Future<void> updateProfilePicture(String imagePath) async {
    try {
      isLoading.value = true;

      final userId = Get.find<UserController>().currentUser.value.id;
      if (userId == null) {
        Get.snackbar('Error', 'User ID not found');
        return;
      }

      final result = await UserModel.uploadProfileImage(
        userId: userId,
        filePath: imagePath,
      );

      if (result) {
        Get.snackbar('Success', 'Profile picture updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update profile picture');
      }
    } catch (e) {
      log('Error updating profile picture: $e');
      Get.snackbar('Error', 'An error occurred while updating profile picture');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToEditProfile() {}
  void navigateToFavorites() {}
  void navigateToMaintenance() {}
  void navigateToHistory() {}
  void navigateToAddCar() {
    Get.toNamed(Routes.ADDCAR);
  }

  void navigateToPaymentMethods() {}
  void navigateToSupport() {}
  void navigateToAbout() {}
  void logout() async {
    await UserModel.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateToDetailsCar(int index) {
    final car = cars[index];
    Get.dialog(
      AlertDialog(
      title: Text(
        'Car Details',
        style: TextStyles.titleSmall(Get.context!).copyWith(
        fontSize: 18.sp, // Using screen util for font size
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          'Model: ${car.model}',
          style: TextStyles.labelMedium(Get.context!).copyWith(
            fontSize: 16.sp,
          ),
          ),
          SizedBox(height: 8.h), // Using screen util for spacing
          Text(
          'Brand: ${car.mark}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
          SizedBox(height: 8.h),
          Text(
          'Year: ${car.year}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
          SizedBox(height: 8.h),
          Text(
          'Engine: ${car.moteur}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
          SizedBox(height: 8.h),
          Text(
          'Transmission: ${car.boiteVitesse.displayName}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
          SizedBox(height: 8.h),
          Text(
          'Fuel Type: ${car.energie.displayName}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
          SizedBox(height: 8.h),
          Text(
          'Car Type: ${car.type.displayName}',
          style: TextStyles.bodyMedium(Get.context!).copyWith(
            fontSize: 14.sp,
          ),
          ),
        ],
        ),
      ),
      actions: [
        TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Close',
          style: TextStyles.button(Get.context!).copyWith(
          fontSize: 14.sp,
          ),
        ),
        ),
        TextButton(
        onPressed: () async {
          final confirm = await Get.dialog(
          AlertDialog(
            title: Text(
            'Confirm Delete',
            style: TextStyles.titleSmall(Get.context!).copyWith(
              fontSize: 18.sp,
            ),
            ),
            content: Text(
            'Are you sure you want to delete this car?',
            style: TextStyles.bodyMedium(Get.context!).copyWith(
              fontSize: 14.sp,
            ),
            ),
            actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(
              'Cancel',
              style: TextStyles.button(Get.context!).copyWith(
                fontSize: 14.sp,
              ),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: Text(
              'Delete',
              style: TextStyles.button(Get.context!).copyWith(
                fontSize: 14.sp,
              ),
              ),
            ),
            ],
          ),
          );
          if (confirm == true) {
          bool deleted = await Car.delete(car.id.toString());

          if (deleted) {
            await cars.removeAt(index);
            Get.back(); // Close the details dialog
            ToastComponent().showToast(
            Get.context!,
            message: 'Car deleted successfully',
            type: ToastTypes.success,
            );
          } else {
            ToastComponent().showToast(
            Get.context!,
            message: 'Failed to delete car',
            type: ToastTypes.error,
            );
          }
          }
        },
        child: Text(
          'Delete',
          style: TextStyles.button(Get.context!).copyWith(
          fontSize: 14.sp,
          ),
        ),
        ),
      ],
      ),
    );
  }

  Future<void> fetchMyCars() async {
    try {
      isLoading.value = true;
      final userId = Get.find<UserController>().currentUser.value.id;
      if (userId == null) {
        Get.snackbar('Error', 'User ID not found');
        return;
      }

      final fetchedCars = await Car.fetchMyCars(userId);
      cars.value = fetchedCars;
      log('Fetched ${cars.length} cars for user $userId');
    } catch (e) {
      log('Error fetching cars: $e');
      Get.snackbar('Error', 'An error occurred while fetching cars');
    } finally {
      isLoading.value = false;
    }
  }
}
