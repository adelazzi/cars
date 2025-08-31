class Car {
  final String make;
  final String model;
  final int year;
  final String color;
  final String imageUrl;

  Car({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Car(make: $make, model: $model, year: $year, color: $color, imageUrl: $imageUrl)';
  }
}