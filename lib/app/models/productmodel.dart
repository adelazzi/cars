class Product {
  final String name;
  final String brand;
  final String image;
  final double price;
  final double originalPrice;
  final double discount;
  final double rating;
  final bool inStock;
  final String category; 

  Product({
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.inStock,
    required this.category,
  });
}
