import 'dart:developer';
import 'dart:io';

import 'package:cars/app/core/components/others/toast_component.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  // Text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController famelynameController = TextEditingController();
  TextEditingController storenameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController wilayaController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<String?> emailerrortext = Rx<String?>(null);
  // Observable variables
  RxBool isPasswordHidden = true.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<DateTime?> selectedBirthDate = Rx<DateTime?>(null);
  Rx<UserType> selectedUserType = Rx<UserType>(UserType.client);
  RxBool isLoading = false.obs;

  // weekend

  RxList<String> selectedWeekends = <String>[].obs;

// List of all days
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

// Toggle day selection
  void toggleWeekend(String day) {
    if (selectedWeekends.contains(day)) {
      selectedWeekends.remove(day);
    } else {
      selectedWeekends.add(day);
    }
  }

  final ToastComponent toastComponent = ToastComponent();

  // Format birth date for display
  String get formattedBirthDate {
    if (selectedBirthDate.value == null) return 'Select Date';
    return DateFormat('yyyy - MM - dd').format(selectedBirthDate.value!);
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Select birth date with date picker
  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate.value ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MainColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: MainColors.textColor(context) ?? Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedBirthDate.value = picked;
    }
  }

  // Change user type
  void changeUserType(UserType type) {
    selectedUserType.value = type;
  }

  Future<void> handleRegistration() async {
    // Validate inputs
    if (nameController.text.isEmpty ||
        phonenumberController.text.isEmpty ||
        adressController.text.isEmpty) {
      toastComponent.showToast(
        Get.context!,
        message: 'Please fill in all required fields',
        type: ToastTypes.error,
      );
      return;
    }

    isLoading.value = true;

    // Show loading indicator
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(Get.context!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      // Create user model
      UserModel newUser = UserModel(
        password: passwordController.text,
        name: selectedUserType.value == UserType.client
            ? ''
            : storenameController.text,
        weekend: selectedUserType.value == UserType.client
            ? ''
            : selectedWeekends.join(','),
        lastName: nameController.text,
        firstName: famelynameController.text,
        username:
            "${nameController.text}_${famelynameController.text}_${selectedBirthDate.value?.year ?? ''}",
        phoneNumber: phonenumberController.text,
        address: adressController.text,
        email: emailController.text,
        wilaya: wilayaController.text,
        commune: communeController.text,
        birthDate:
            '${selectedBirthDate.value!.year}-${selectedBirthDate.value!.month}-${selectedBirthDate.value!.day}',
        userType: selectedUserType.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        verified: false,
        premium: false,
        disponible: true,
      );

      // Simulate API call
      UserModel? registeredUser = await UserModel.register(
        newUser,
      );
      await updateProfilePicture();
      isLoading.value = false;
      Get.back(); // Close loading dialog

      if (registeredUser != null) {
        // Show success message
        toastComponent.showToast(
          Get.context!,
          message: 'Your account has been created successfully',
          type: ToastTypes.success,
        );
        Get.find<UserController>().currentUser.value = registeredUser;
        // Navigate to next screen or login
        Get.offAllNamed(Routes.MAIN);
      } else {
        // Show error message
        toastComponent.showToast(
          Get.context!,
          message: 'Failed to create your account. Please try again.',
          type: ToastTypes.error,
        );
      }
    } catch (error) {
      isLoading.value = false;
      Get.back(); // Close loading dialog

      // Show error message
      toastComponent.showToast(
        Get.context!,
        message: 'An error occurred: $error',
        type: ToastTypes.error,
      );
    }
  }

  Future<void> updateProfilePicture() async {
    try {
      isLoading.value = true;

      final userId = Get.find<UserController>().currentUser.value.id;
      if (userId == null) {
        Get.snackbar('Error', 'User ID not found');
        return;
      }

      final result = await UserModel.uploadProfileImage(
        userId: userId,
        filePath: selectedImage.value!.path,
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
}
