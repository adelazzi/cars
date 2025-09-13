import 'package:cars/app/core/components/others/languagebottomsheet.dart';
import 'package:cars/app/core/components/others/toast_component.dart';
import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Add your controller logic here
  RxBool isLoading = false.obs;
  RxBool rememberMe = true.obs;
  RxBool isPasswordHidden = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? password;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showToast('Please fill in all fields', ToastTypes.error);
      return;
    }

    isLoading.value = true;

    try {
      String fcmToken = await LocalStorageService.loadData(
        key: StorageKeysConstants.fcmToken,
        type: DataTypes.string,
      );

      UserModel? user = await UserModel.login(
        email: emailController.text.trim(),
        password: passwordController.text,
        fcmToken: fcmToken,
      );

      await LocalStorageService.saveData(
        key: StorageKeysConstants.userToken,
        type: DataTypes.string,
        value: Get.find<UserController>().Token,
      );

      if (user! != null) {
        await _handleSuccessfulLogin(user);
      } else {
        _showToast('Invalid email or password', ToastTypes.error);
      }
    } catch (e) {
      _showToast('An error occurred. Please try again.', ToastTypes.error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleSuccessfulLogin(UserModel user) async {
    Get.find<UserController>().currentUser.value = user;

    await LocalStorageService.saveData(
      key: StorageKeysConstants.userId,
      value: user.id,
      type: DataTypes.int,
    );

    Get.offAndToNamed(Routes.MAIN);
    _showToast('Login successful', ToastTypes.success);
  }

  void _showToast(String message, ToastTypes type) {
    ToastComponent().showToast(
      Get.context!,
      message: message,
      type: type,
    );
  }

  void toggleLanguage() {}
}
