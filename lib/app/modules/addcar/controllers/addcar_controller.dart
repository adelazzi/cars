import 'dart:developer';

import 'package:cars/app/modules/profile/controllers/profile_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';

class AddcarController extends GetxController {
  Future<void> addCar(Car car) async {
    try {
      Car newcar = await Car.create(car);
      Get.snackbar('Success', 'Car added successfully');
    } catch (e) {
      log('Error adding car: ${e.toString()}');
      Get.snackbar('Error', 'Failed to add car: ${e.toString()}');
    }
  }
}
