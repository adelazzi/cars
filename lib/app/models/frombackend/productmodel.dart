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
      storeId: json['storeId'],
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      promotionPrice: json['promotionPrice'] != null ? json['promotionPrice'].toDouble() : null,
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'promotionPrice': promotionPrice,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
