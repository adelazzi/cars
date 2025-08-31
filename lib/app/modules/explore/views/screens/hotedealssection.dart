import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/models/productmodel.dart';
import 'package:cars/app/modules/explore/views/cards/productcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Product> featuredProducts;

  const FeaturedProducts({Key? key, required this.featuredProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h, // Use ScreenUtil for responsive height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
        itemCount: featuredProducts.length,
        itemBuilder: (context, index) {
          final product = featuredProducts[index];
          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}
