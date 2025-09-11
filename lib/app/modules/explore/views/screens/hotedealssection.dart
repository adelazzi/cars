import 'package:cars/app/core/components/others/titelsection.dart';
import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/models/frombackend/productmodel.dart';
import 'package:cars/app/modules/explore/views/cards/productcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Product> featuredProducts;
  final String title;
  final String subtitle;
  final VoidCallback onpressed;

  const FeaturedProducts(
      {Key? key,
      required this.featuredProducts,
      required this.title,
      required this.subtitle,
      required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h, // Use ScreenUtil for responsive height
      child: Column(
        children: [
          TitleSection(
            title: title,
            subtitle: subtitle,
            onpressed: onpressed,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return ProductCard(
                  product: product,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
