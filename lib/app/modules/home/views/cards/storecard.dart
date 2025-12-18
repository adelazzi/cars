import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:get/get.dart';

class StoreCard extends StatelessWidget {
  final UserModel store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.STOREDETAILS, arguments: store.id);
      },
      child: Container(
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
                    image: store.profileImage != null &&
                            store.profileImage!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(store.profileImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      store.profileImage == null || store.profileImage!.isEmpty
                          ? Icon(Icons.store, color: Colors.white, size: 24.sp)
                          : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            store.name ?? 'Unknown Store',
                            style: TextStyles.bodyMedium(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (store.verified) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.verified,
                              color:
                                  MainColors.infoColor(context) ?? Colors.blue,
                              size: 16.sp,
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            '${store.rating.toStringAsFixed(1)}',
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
            if (store.premium) ...[
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
                  'Premium Partner',
                  style: TextStyles.bodySmall(context).copyWith(
                    color: MainColors.successColor(context)?.withOpacity(0.7) ??
                        Colors.green[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            Text(
              store.address ?? '${store.wilaya ?? ""}, ${store.commune ?? ""}',
              style: TextStyles.bodySmall(context).copyWith(
                color: MainColors.textColor(context)?.withOpacity(0.6) ??
                    Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
