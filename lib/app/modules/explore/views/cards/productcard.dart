import 'package:cars/app/models/frombackend/productmodel.dart';
import 'package:flutter/material.dart';

import 'package:cars/app/models/frombackend/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w, bottom: 8.h),
      decoration: BoxDecoration(
        color: MainColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 6.r,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                ),
              ),
              if (product.promotionPrice != null)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: MainColors.errorColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '-${((1 - (product.promotionPrice! / product.price)) * 100).toInt()}%',
                      style: TextStyles.bodySmall(context).copyWith(
                        color: MainColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyles.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: MainColors.textColor(context),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  product.description,
                  style: TextStyles.bodySmall(context).copyWith(
                    color: MainColors.textColor(context)!.withOpacity(0.6),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '${product.promotionPrice ?? product.price} DZD',
                      style: TextStyles.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: MainColors.successColor(context),
                      ),
                    ),
                    if (product.promotionPrice != null) ...[
                      SizedBox(width: 8.w),
                      Text(
                        '${product.price} DZD',
                        style: TextStyles.bodySmall(context).copyWith(
                          color: MainColors.textColor(context)!.withOpacity(0.6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
