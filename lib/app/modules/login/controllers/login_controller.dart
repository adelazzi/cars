import 'package:cars/app/core/components/others/languagebottomsheet.dart';
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

  void login() {
    Get.offAndToNamed(Routes.MAIN);
  }

  void toggleLanguage() {}
}
