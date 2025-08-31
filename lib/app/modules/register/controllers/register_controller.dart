import 'dart:io';

import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Add your controller logic here
  TextEditingController nameController = TextEditingController();
  TextEditingController famelynameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);






  void handleRegistration() {
    // Show loading indicator
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MainColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(MainColors.primaryColor),
              ),
              SizedBox(height: 16),
              Text(
                'Creating your account...',
                style: TextStyle(
                  fontSize: 16,
                  color: MainColors.textColor(Get.context!)?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Simulate registration process
    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Close loading dialog
      Get.snackbar(
        'Success!',
        'Your account has been created successfully',
        backgroundColor:
            MainColors.successColor(Get.context!)?.withOpacity(0.8),
        colorText: MainColors.whiteColor,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
        borderRadius: 12,
        duration: Duration(seconds: 3),
      );
    });
  }
}
