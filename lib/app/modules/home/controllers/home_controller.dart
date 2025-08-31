import 'dart:async';

import 'package:cars/app/models/ordermodel.dart';
import 'package:cars/app/models/storemodel.dart';
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
  final List<Store> topStores = [
    Store(
      name: 'AutoParts Pro',
      rating: 4.9,
      productsCount: 15420,
      image:
          'https://img.freepik.com/vecteurs-libre/modele-logo-service-voiture-degrade_23-2149727258.jpg?w=360',
      verified: true,
      discount: '15% OFF',
    ),
    Store(
      name: 'Speed Motors',
      rating: 4.7,
      productsCount: 8350,
      image:
          'https://img.freepik.com/vecteurs-libre/creation-logo-degrade-pieces-automobiles_23-2149460685.jpg',
      verified: true,
      discount: 'Free Shipping',
    ),
    Store(
      name: 'Car Zone Plus',
      rating: 4.8,
      productsCount: 12180,
      image:
          'https://img.freepik.com/vecteurs-libre/modele-logo-service-voiture-degrade_23-2149727273.jpg?w=360',
      verified: false,
      discount: '20% OFF',
    ),
  ];
}
