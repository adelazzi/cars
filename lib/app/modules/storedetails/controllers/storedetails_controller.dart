import 'dart:developer';

import 'package:cars/app/modules/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:url_launcher/url_launcher.dart';

class StoredetailsController extends GetxController {
  final Rx<UserModel> store = UserModel.empty().obs;
  final RxBool isLoading = true.obs;
  final RxBool isFavorite = false.obs;
  final RxList<String> storeServices = <String>[].obs;
  final RxInt selectedTabIndex = 0.obs;

  final ScrollController scrollController = ScrollController();
  final RxBool showAppBarTitle = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStoreDetails();
    log('thisis token' + Get.find<UserController>().Token);
    // Listen for scroll to change AppBar appearance
    scrollController.addListener(() {
      showAppBarTitle.value = scrollController.offset > 140;
    });

    // Mock services data - replace with real data
    storeServices.value = [
      'Oil Change',
      'Brake Service',
      'Engine Repair',
      'Tire Replacement',
      'Diagnostics'
    ];
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadStoreDetails() async {
    isLoading.value = true;
    try {
      final storeId = Get.arguments as int?;
      if (storeId != null) {
        final storeData = await UserModel.getUserById(storeId);
        if (storeData != null) {
          store.value = storeData;
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar('Error', 'Store ID not provided');
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', 'Failed to load store details');
      });
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite() {
    isFavorite.toggle();
    // TODO: Implement backend favorite functionality
  }

  void contactStore() {
    if (store.value.phoneNumber != null &&
        store.value.phoneNumber!.isNotEmpty) {
      final phoneNumber =
          store.value.phoneNumber!.replaceAll(RegExp(r'[^\d+]'), '');
      try {
        launchUrl(Uri.parse('tel:$phoneNumber'));
      } catch (e) {
        Get.snackbar('Error', 'Could not make the call');
      }
    } else {
      Get.snackbar(
          'Contact', 'No phone number available for ${store.value.name}');
    }
  }

  void addreview() {
    // TODO: Navigate to booking screen
    Get.snackbar('Book', 'Booking appointment with ${store.value.name}');
  }
}
