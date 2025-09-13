import 'package:cars/app/core/services/http_client_service.dart';

class Product {
  final int storeId;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final double? promotionPrice;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.storeId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.promotionPrice,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      storeId: json['store_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      promotionPrice: json['promotion_price'] != null ? json['promotionPrice'].toDouble() : null,
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'promotion_price': promotionPrice,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }



  /////// API Methods ///////
  static Future<List<Product>> fetchAll() async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/products',
      requestType: HttpRequestTypes.get,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is List) {
      return (response.body as List)
          .map((item) => Product.fromJson(item))
          .toList();
    }

    throw Exception('Failed to fetch products');
  }

  static Future<Product> getDetails(int id) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/products/$id',
      requestType: HttpRequestTypes.get,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return Product.fromJson(response.body);
    }

    throw Exception('Failed to fetch product details');
  }

  static Future<void> delete(int id) async {
    await HttpClientService.sendRequest(
      endPoint: '/products/$id',
      requestType: HttpRequestTypes.delete,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );
  }

  static Future<Product> update(Product product) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/products/${product.storeId}',
      requestType: HttpRequestTypes.put,
      data: product.toJson(),
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return Product.fromJson(response.body);
    }

    throw Exception('Failed to update product');
  }

}
