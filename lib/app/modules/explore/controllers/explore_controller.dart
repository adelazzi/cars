import 'dart:developer';

import 'package:cars/app/models/frombackend/subcategory.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:get/get.dart';

import '../../../models/frombackend/productmodel.dart';

class ExploreController extends GetxController {
  var currentBannerIndex = 0.obs;
  var selectedCategory = 'All'.obs;
  var searchQuery = ''.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  User_brands.fetchTopBrands().then((brands) {
    topBrands.assignAll(brands);
  }).catchError((error) {
    log('Error fetching top brands: $error');
  });
  }



  final List<CategoryEnum> categories = CategoryEnum.values;

  final List<Product> featuredProducts = [
    Product(
      storeId: 9,
      categoryId: 9,
      name: 'Brake Pads Set',
      description: 'High-performance brake pads for safe braking.',
      price: 89.99,
      promotionPrice: 79.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/composition-differents-accessoires-voiture_23-2149030397.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 10,
      categoryId: 10,
      name: 'LED Headlights',
      description: 'Bright and energy-efficient LED headlights.',
      price: 159.99,
      promotionPrice: 149.99,
      imageUrl:
          'https://img.freepik.com/psd-gratuit/amortisseur-automobile-rendu-3d-fond-transparent_363450-6579.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 11,
      categoryId: 11,
      name: 'Air Filter',
      description: 'Durable air filter for improved engine performance.',
      price: 45.99,
      promotionPrice: 39.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/differents-assortiments-accessoires-voiture_23-2149030432.jpg',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 12,
      categoryId: 12,
      name: 'Shock Absorbers',
      description: 'Reliable shock absorbers for a smooth ride.',
      price: 299.99,
      promotionPrice: 269.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/led-phare-voiture-bleue_23-2147962992.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<UserModel> topStores = [
    UserModel(
      name: 'AutoParts Pro',
      disponible: true,
      address: '123 Main Street',
      phoneNumber: '123-456-7890',
      email: 'contact@autopartspro.com',
      userType: UserType.store,
      fcmToken: 'token123',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      name: 'Speed Motors',
      disponible: true,
      address: '456 Elm Street',
      phoneNumber: '987-654-3210',
      email: 'info@speedmotors.com',
      userType: UserType.store,
      fcmToken: 'token456',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      name: 'Car Zone Plus',
      disponible: false,
      address: '789 Oak Avenue',
      phoneNumber: '555-123-4567',
      email: 'support@carzoneplus.com',
      userType: UserType.store,
      fcmToken: 'token789',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<User_brands> topBrands =[];



  final List<Product> Productscat1 = [
    Product(
      storeId: 1,
      categoryId: 1,
      name: 'All-Season Tires',
      description: 'High-quality all-season tires for your vehicle.',
      price: 499.99,
      promotionPrice: 424.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/pneu-voiture-neuf_23-2147962993.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 2,
      categoryId: 2,
      name: 'Car Battery',
      description: 'Reliable car battery with long-lasting performance.',
      price: 129.99,
      promotionPrice: 103.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/batterie-voiture-isolee_23-2147962994.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 3,
      categoryId: 3,
      name: 'Oil Filter',
      description: 'Efficient oil filter for optimal engine performance.',
      price: 19.99,
      promotionPrice: 14.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/filtre-huile-voiture_23-2147962995.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 4,
      categoryId: 4,
      name: 'Wiper Blades',
      description: 'Durable wiper blades for clear visibility.',
      price: 29.99,
      promotionPrice: 26.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/essuie-glace-voiture_23-2147962996.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<Product> Productscat2 = [
    Product(
      storeId: 5,
      categoryId: 5,
      name: 'Synthetic Motor Oil',
      description: 'Premium synthetic motor oil for engine protection.',
      price: 39.99,
      promotionPrice: 34.99,
      imageUrl:
          'https://img.freepik.com/vecteurs-libre/banniere-huile-moteur-boite-plastique-realiste-pour-huile-moteur_1284-58774.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 6,
      categoryId: 6,
      name: 'Coolant',
      description: 'High-performance coolant for engine cooling.',
      price: 24.99,
      promotionPrice: 21.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/bouteille-liquide-refroidissement_23-2147962998.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 7,
      categoryId: 7,
      name: 'Brake Fluid',
      description: 'Reliable brake fluid for smooth braking.',
      price: 14.99,
      promotionPrice: 12.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/coussinets-rouges-pedale-volant-voiture_114579-4035.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      storeId: 8,
      categoryId: 8,
      name: 'Transmission Fluid',
      description: 'High-quality transmission fluid for smooth shifting.',
      price: 29.99,
      promotionPrice: 26.99,
      imageUrl:
          'https://img.freepik.com/photos-gratuite/bouteille-liquide-transmission_23-2147963000.jpg?w=360',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}
