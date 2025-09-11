import 'dart:async';

import 'package:cars/app/models/frombackend/ordermodel.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Add your controller logic here

  ///////////////////////////// banner section

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    _startAutoPlay();
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void _startAutoPlay() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentPage.value < 2) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void onBannerTap(String bannerType) {
    // Handle different banner taps
    switch (bannerType) {
      case 'parts':
        // Navigate to parts page
        Get.toNamed('/parts');
        break;
      case 'delivery':
        // Navigate to delivery info
        Get.toNamed('/delivery');
        break;
      case 'service':
        // Navigate to service page
        Get.toNamed('/service');
        break;
    }
  }

  //////////////////////////// Store section
  final List<UserModel> topStores = [
    UserModel(
      name: 'AutoParts Pro',
      userType: UserType.store,
      profileImage:
          'https://img.freepik.com/vecteurs-libre/modele-logo-service-voiture-degrade_23-2149727258.jpg?w=360',
      disponible: true,
      address: '15420 products available',
      weekend: '15% OFF',
    ),
    UserModel(
      name: 'Speed Motors',
      userType: UserType.store,
      profileImage:
          'https://img.freepik.com/vecteurs-libre/creation-logo-degrade-pieces-automobiles_23-2149460685.jpg',
      disponible: true,
      address: '8350 products available',
      weekend: 'Free Shipping',
    ),
    UserModel(
      name: 'Car Zone Plus',
      userType: UserType.store,
      profileImage:
          'https://img.freepik.com/vecteurs-libre/modele-logo-service-voiture-degrade_23-2149727273.jpg?w=360',
      disponible: false,
      address: '12180 products available',
      weekend: '20% OFF',
    ),
  ];
}
