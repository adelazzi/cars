import 'dart:developer';

import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // Add your controller logic here
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nextPage();
  }

  void nextPage() async {
    // Wait for 2 seconds before navigating to the next page
    await Future.delayed(const Duration(seconds: 2));

    try {
      final token = await LocalStorageService.loadData(
        key: StorageKeysConstants.userToken,
        type: DataTypes.string,
      );
      final userId = await LocalStorageService.loadData(
        key: StorageKeysConstants.userId,
        type: DataTypes.int,
      );

      bool checktoken = await UserModel.ckeckToken(token);

      if (token != null && userId != null && userId > 0 && checktoken == true) {
        final userController = Get.find<UserController>();
        userController.Token = token;
        userController.currentUser.value.id = userId;
        userController.RefreshUserData();

        log('Token: $token');
        log('UserID: $userId');
        Get.offNamed(Routes.MAIN);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    } catch (e) {
      log('Error in nextPage: $e');
      Get.offNamed(Routes.LOGIN);
    }
  }
}
