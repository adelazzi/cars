import 'dart:developer';

import 'package:cars/app/core/components/others/toast_component.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';

class AddcarController extends GetxController {
  Future<void> addCar(Car car) async {
    try {
      Car newcar = await Car.create(car);
      Get.back();
      final context = Get.context;
      if (context != null) {
        ToastComponent().showToast(
          context,
          message: StringsAssetsConstants.car_added_successfully,
          type: ToastTypes.success,
        );
      } else {
        Get.snackbar('Success', 'Car added successfully');
      }
    } catch (e) {
      log('Error adding car: ${e.toString()}');
      final context = Get.context;
      if (context != null) {
        ToastComponent().showToast(
          context,
          message:
              StringsAssetsConstants.failed_to_add_car + ' : ${e.toString()}',
          type: ToastTypes.error,
        );
      } else {
        Get.snackbar('Error', 'Failed to add car: ${e.toString()}');
      }
    }
  }
}
