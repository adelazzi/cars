import 'dart:async';
import 'dart:developer';

import 'package:cars/app/models/frombackend/adsmodel.dart';
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
  RxList<AdsModel> ads = <AdsModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startAutoPlay();
    fetchmydata();
  }

  void fetchmydata() async {
    isLoading.value = true;
    update();
    await fetchAds();
    await fetchTopBrands();
    await fetchStores();
    isLoading.value = false;
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void _startAutoPlay() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (ads.isNotEmpty) {
        if (currentPage.value < ads.length - 1) {
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

  Future<void> fetchAds() async {
    try {
      ads.clear(); // Clear the list before fetching new data
      final pagination = await AdsModel.fetchAll();
      final fetchedAds = pagination.results ?? [];
      ads.assignAll(fetchedAds);
      log('lenth ads: ${fetchedAds.length}');
    } catch (e) {
      print('Error fetching ads: $e');
    }
  }

  //////////////////////////// Store section
  List<UserModel> topStores = <UserModel>[].obs;
  RxList<UserModel> allStores = <UserModel>[].obs;
  RxBool isLoadingStores = false.obs;

  Future<void> fetchStores() async {
    try {
      isLoadingStores.value = true;
      final pagination = await UserModel.fetchAllStores();
      final stores = pagination.results ?? [];
      topStores.clear();
      topStores.assignAll(stores);
      log('Fetched ${stores.length} stores successfully');
    } catch (e) {
      log('Error fetching stores: $e');
    } finally {
      isLoadingStores.value = false;
    }
  }

/////////////////////////////////// Brands part

  final List<User_brands> topBrands = [];

  Future<void> fetchTopBrands() async {
    topBrands.clear();
    final brands = await User_brands.fetchTopBrands();
    topBrands.addAll(brands);
    update(); // Notify listeners about the change
  }
}
