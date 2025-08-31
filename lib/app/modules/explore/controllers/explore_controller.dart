import 'package:cars/app/models/brandmodel.dart';
import 'package:cars/app/models/CarsBrandmodel.dart';
import 'package:cars/app/models/storemodel.dart';
import 'package:get/get.dart';

import '../../../models/productmodel.dart';

class ExploreController extends GetxController {
  var currentBannerIndex = 0.obs;
  var selectedCategory = 'All'.obs;
  var searchQuery = ''.obs;

  final List<String> categories = [
    'All',
    'Engine',
    'Brakes',
    'Suspension',
    'Electrical',
    'Body'
  ];

  final List<Product> featuredProducts = [
    Product(
      discount: 10,
      name: 'Brake Pads Set',
      brand: 'Brembo',
      price: 89.99,
      originalPrice: 129.99,
      rating: 4.8,
      image:
          'https://img.freepik.com/photos-gratuite/composition-differents-accessoires-voiture_23-2149030397.jpg?w=360',
      category: 'Brakes',
      inStock: true,
    ),
    Product(
      discount: 10,
      name: 'LED Headlights',
      brand: 'Philips',
      price: 159.99,
      originalPrice: 199.99,
      rating: 4.9,
      image:
          'https://img.freepik.com/psd-gratuit/amortisseur-automobile-rendu-3d-fond-transparent_363450-6579.jpg',
      category: 'Electrical',
      inStock: true,
    ),
    Product(
      discount: 10,
      name: 'Air Filter',
      brand: 'K&N',
      price: 45.99,
      originalPrice: 59.99,
      rating: 4.7,
      image:
          'https://img.freepik.com/photos-gratuite/differents-assortiments-accessoires-voiture_23-2149030432.jpg',
      category: 'Engine',
      inStock: false,
    ),
    Product(
      discount: 10,
      name: 'Shock Absorbers',
      brand: 'Bilstein',
      price: 299.99,
      originalPrice: 399.99,
      rating: 4.8,
      image:
          'https://img.freepik.com/photos-gratuite/led-phare-voiture-bleue_23-2147962992.jpg?w=360',
      category: 'Suspension',
      inStock: true,
    ),
  ];

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

  final List<Brand> topBrands = carBrandsList
      .map((car) => Brand(
            name: car.name ?? '',
            logo: car.image ?? '',
            popularity: 0, // Default popularity, can be updated as needed
          ))
      .toList()
      .sublist(1, 10);

  final List<Product> Productscat1 = [
    Product(
      discount: 15,
      name: 'All-Season Tires',
      brand: 'Michelin',
      price: 499.99,
      originalPrice: 599.99,
      rating: 4.9,
      image:
          'https://img.freepik.com/photos-gratuite/pneu-voiture-neuf_23-2147962993.jpg?w=360',
      category: 'Body',
      inStock: true,
    ),
    Product(
      discount: 20,
      name: 'Car Battery',
      brand: 'Bosch',
      price: 129.99,
      originalPrice: 159.99,
      rating: 4.8,
      image:
          'https://img.freepik.com/photos-gratuite/batterie-voiture-isolee_23-2147962994.jpg?w=360',
      category: 'Electrical',
      inStock: true,
    ),
    Product(
      discount: 25,
      name: 'Oil Filter',
      brand: 'Mobil 1',
      price: 19.99,
      originalPrice: 24.99,
      rating: 4.7,
      image:
          'https://img.freepik.com/photos-gratuite/filtre-huile-voiture_23-2147962995.jpg?w=360',
      category: 'Engine',
      inStock: true,
    ),
    Product(
      discount: 10,
      name: 'Wiper Blades',
      brand: 'Rain-X',
      price: 29.99,
      originalPrice: 34.99,
      rating: 4.6,
      image:
          'https://img.freepik.com/photos-gratuite/essuie-glace-voiture_23-2147962996.jpg?w=360',
      category: 'Body',
      inStock: false,
    ),
  ];

  final List<Product> Productscat2 = [
    Product(
      discount: 15,
      name: 'All-Season Tires',
      brand: 'Michelin',
      price: 499.99,
      originalPrice: 599.99,
      rating: 4.9,
      image:
          'https://img.freepik.com/photos-gratuite/pneu-voiture-neuf_23-2147962993.jpg?w=360',
      category: 'Body',
      inStock: true,
    ),
    Product(
      discount: 20,
      name: 'Car Battery',
      brand: 'Bosch',
      price: 129.99,
      originalPrice: 159.99,
      rating: 4.8,
      image:
          'https://img.freepik.com/photos-gratuite/batterie-voiture-isolee_23-2147962994.jpg?w=360',
      category: 'Electrical',
      inStock: true,
    ),
    Product(
      discount: 25,
      name: 'Oil Filter',
      brand: 'Mobil 1',
      price: 19.99,
      originalPrice: 24.99,
      rating: 4.7,
      image:
          'https://img.freepik.com/photos-gratuite/filtre-huile-voiture_23-2147962995.jpg?w=360',
      category: 'Engine',
      inStock: true,
    ),
    Product(
      discount: 10,
      name: 'Wiper Blades',
      brand: 'Rain-X',
      price: 29.99,
      originalPrice: 34.99,
      rating: 4.6,
      image:
          'https://img.freepik.com/photos-gratuite/essuie-glace-voiture_23-2147962996.jpg?w=360',
      category: 'Body',
      inStock: false,
    ),
  ];

  final List<Product> Productscat3 = [
    Product(
      discount: 10,
      name: 'Synthetic Motor Oil',
      brand: 'Castrol',
      price: 39.99,
      originalPrice: 49.99,
      rating: 4.8,
      image:
          'https://img.freepik.com/vecteurs-libre/banniere-huile-moteur-boite-plastique-realiste-pour-huile-moteur_1284-58774.jpg?w=360',
      category: 'Oil & Fluids',
      inStock: true,
    ),
    Product(
      discount: 15,
      name: 'Coolant',
      brand: 'Prestone',
      price: 24.99,
      originalPrice: 29.99,
      rating: 4.7,
      image:
          'https://img.freepik.com/photos-gratuite/bouteille-liquide-refroidissement_23-2147962998.jpg?w=360',
      category: 'Oil & Fluids',
      inStock: true,
    ),
    Product(
      discount: 20,
      name: 'Brake Fluid',
      brand: 'DOT 4',
      price: 14.99,
      originalPrice: 18.99,
      rating: 4.6,
      image:
'https://img.freepik.com/photos-gratuite/coussinets-rouges-pedale-volant-voiture_114579-4035.jpg?w=360',
      category: 'Oil & Fluids',
      inStock: true,
    ),
    Product(
      discount: 10,
      name: 'Transmission Fluid',
      brand: 'Valvoline',
      price: 29.99,
      originalPrice: 34.99,
      rating: 4.7,
      image:
          'https://img.freepik.com/photos-gratuite/bouteille-liquide-transmission_23-2147963000.jpg?w=360',
      category: 'Oil & Fluids',
      inStock: false,
    ),
  ];
}
