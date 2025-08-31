import 'package:cars/app/models/storemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(right: 16.w, bottom: 8.h, top: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context) ?? Colors.white,
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
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context)!,
                      blurRadius: 6.r,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                  gradient: MainColors.primaryGradientColor,
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: NetworkImage(store.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          store.name,
                          style: TextStyles.bodyMedium(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (store.verified) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.verified,
                            color: MainColors.infoColor(context) ?? Colors.blue,
                            size: 16.sp,
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.sp),
                        Text(
                          '${store.rating} • ${store.productsCount} products',
                          style: TextStyles.bodySmall(context).copyWith(
                            color: MainColors.textColor(context)
                                    ?.withOpacity(0.6) ??
                                Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: MainColors.successColor(context)?.withOpacity(0.1) ??
                  Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: MainColors.successColor(context)?.withOpacity(0.3) ??
                    Colors.green.withOpacity(0.3),
              ),
            ),
            child: Text(
              store.discount,
              style: TextStyles.bodySmall(context).copyWith(
                color: MainColors.successColor(context)?.withOpacity(0.7) ??
                    Colors.green[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Trusted seller with fast delivery',
            style: TextStyles.bodySmall(context).copyWith(
              color: MainColors.textColor(context)?.withOpacity(0.6) ??
                  Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
