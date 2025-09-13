import 'package:cars/app/core/services/http_client_service.dart';
import 'package:flutter/foundation.dart';

enum CategoryEnum {
  ENGINE_PERFORMANCE("Engine & Performance", "المحرك والأداء"),
  ELECTRICAL_ELECTRONICS("Electrical & Electronics", "الكهرباء والإلكترونيات"),
  LUBRICANTS_FLUIDS("Lubricants & Fluids", "الزيوت والسوائل"),
  FUEL_SYSTEM("Fuel System", "نظام الوقود"),
  EXHAUST_EMISSION("Exhaust & Emission", "العادم والانبعاثات"),
  COOLING_SYSTEM("Cooling System", "نظام التبريد"),
  TRANSMISSION_DRIVETRAIN("Transmission & Drivetrain", "ناقل الحركة ونظام الدفع"),
  BRAKES("Brakes", "الفرامل"),
  SUSPENSION_STEERING("Suspension & Steering", "التعليق والتوجيه"),
  BODY_EXTERIOR("Body & Exterior", "الهيكل والخارجية"),
  INTERIOR_COMFORT("Interior & Comfort", "الداخلية والراحة"),
  TIRES_WHEELS("Tires & Wheels", "الإطارات والعجلات"),
  GLASS_LIGHTING("Glass & Lighting", "الزجاج والإضاءة"),
  ACCESSORIES_MISC("Accessories & Misc.", "الإكسسوارات والمتفرقات");

  final String englishName;
  final String arabicName;

  const CategoryEnum(this.englishName, this.arabicName);
}

class SubCategory {
  final String subcategoryName;
  final CategoryEnum categoryName;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubCategory({
    required this.subcategoryName,
    required this.categoryName,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subcategoryName: json['subcategory_name'],
      categoryName: CategoryEnum.values.firstWhere(
        (e) => e.name == json['category_name'],
        orElse: () => throw ArgumentError('Invalid category name'),
      ),
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory_name': subcategoryName,
      'category_name': categoryName.name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }






  /////// API Methods ///////

  static Future<List<SubCategory>> fetchAll({String? q , bool? ar }) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/subcategory/all',
      requestType: HttpRequestTypes.get,
      queryParameters: q != null ? {'q': q} : null,
      header: ar != null ? {'lang': 'ar'} : null,
    );

    if (response != null &&
        response.statusCode == 200 &&
        response.body is List) {
      return (response.body as List)
          .map((item) => SubCategory.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }





}