import 'package:cars/app/models/productmodel.dart';
import 'package:flutter/material.dart';

import 'package:cars/app/models/productmodel.dart';
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
                    image: NetworkImage(product.image),
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
                child: product.inStock
                    ? null
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.r)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              MainColors.blackColor.withOpacity(0.7),
                              MainColors.blackColor.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Center(
                          child: product.inStock
                              ? SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: MainColors.errorColor(context),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    'Out of Stock',
                                    style:
                                        TextStyles.bodySmall(context).copyWith(
                                      color: MainColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        )),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: MainColors.errorColor(context),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '-${product.discount.toInt()}%',
                    style: TextStyles.bodySmall(context).copyWith(
                      color: MainColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: MainColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 20.sp,
                    color: MainColors.shadowColor(context),
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
                SizedBox(height: 4.h),
                Text(
                  product.brand,
                  style: TextStyles.bodySmall(context).copyWith(
                    color: MainColors.textColor(context)!.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: MainColors.warningColor(context), size: 16.sp),
                    Text(
                      '${product.rating}',
                      style: TextStyles.bodySmall(context).copyWith(
                        color: MainColors.textColor(context),
                      ),
                    ),
                    Spacer(),
                    if (!product.inStock)
                      Text(
                        'Out of Stock',
                        style: TextStyles.bodySmall(context).copyWith(
                          color: MainColors.errorColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 50.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${product.price} DZD',
                        style: TextStyles.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: MainColors.successColor(context),
                        ),
                      ),
                      Text(
                        '${product.originalPrice} DZD',
                        style: TextStyles.bodySmall(context).copyWith(
                          color:
                              MainColors.textColor(context)!.withOpacity(0.6),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
