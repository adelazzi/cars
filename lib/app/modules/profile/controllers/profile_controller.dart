import 'dart:developer';

import 'package:cars/app/models/CarsBrandmodel.dart';
import 'package:cars/app/models/carmodel.dart';
import 'package:cars/app/models/usermodel.dart';
import 'package:cars/app/modules/main/controllers/main_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
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
    Get.find<UserController>().setUser();

    cars.value = [
      Car(
        id: '0',
        clientid: '001',
        mark: 'Toyota',
        model: 'Camry',
        year: 2020,
        moteur: 'hybrid',
        energie: FuelType.GPL,
        type: CarType.voiture,
        boiteVitesse: Transmission.manual,
      ),
      Car(
        id: '1',
        clientid: '123',
        mark: 'Honda',
        model: 'Civic',
        year: 2019,
        moteur: 'essence',
        energie: FuelType.essence,
        type: CarType.bus,
        boiteVitesse: Transmission.automatic,
      ),
    ];

    log(cars.value.length.toString());
    refresh();
    print('Profile refreshed');
  }

  void updateProfilePicture() {}
  void navigateToEditProfile() {}
  void navigateToCars() {}
  void navigateToFavorites() {}
  void navigateToMaintenance() {}
  void navigateToHistory() {}
  void navigateToAddCar() {}
  void navigateToPaymentMethods() {}
  void navigateToSupport() {}
  void navigateToAbout() {}
  void logout() {}
  void navigateToEditCar(int index) {}
}
