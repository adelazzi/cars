import 'dart:developer';

import 'package:cars/app/models/CarsBrandmodel.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/main/controllers/main_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:cars/app/routes/app_pages.dart';
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
    // cars.value = [
    //   Car(
    //     id: '0',
    //     clientid: '001',
    //     mark: 'Toyota',
    //     model: 'Camry',
    //     year: 2020,
    //     moteur: 'hybrid',
    //     energie: FuelType.GPL,
    //     type: CarType.voiture,
    //     boiteVitesse: Transmission.manual,
    //   ),
    //   Car(
    //     id: '1',
    //     clientid: '123',
    //     mark: 'Honda',
    //     model: 'Civic',
    //     year: 2019,
    //     moteur: 'essence',
    //     energie: FuelType.essence,
    //     type: CarType.bus,
    //     boiteVitesse: Transmission.automatic,
    //   ),
    // ];
    cars.value = [];
    log(Get.find<UserController>().currentUser.value.premium.toString());
    log(cars.value.length.toString());
    refresh();
    print('Profile refreshed');
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
  void navigateToCars() {}
  void navigateToFavorites() {}
  void navigateToMaintenance() {}
  void navigateToHistory() {}
  void navigateToAddCar() {}
  void navigateToPaymentMethods() {}
  void navigateToSupport() {}
  void navigateToAbout() {}
  void logout() async {
    await Get.find<UserController>().logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateToEditCar(int index) {}
}
